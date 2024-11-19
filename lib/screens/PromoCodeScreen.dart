import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/CodePromo.dart';
import '../services/CodePromoServices.dart';

class PromoCodeScreen extends StatefulWidget {
  @override
  _PromoCodeScreenState createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  final CodePromoService _codePromoService = CodePromoService();
  List<CodePromo> _promoCodes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPromoCodes();
  }

  Future<void> _fetchPromoCodes() async {
    setState(() => _isLoading = true);
    try {
      final promoCodes = await _codePromoService.fetchPromoCodes();
      setState(() => _promoCodes = promoCodes);
    } catch (e) {
      _showErrorDialog('Error fetching promo codes');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _addPromoCode() async {
    final codeController = TextEditingController();
    final reductionController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Promo Code', style: TextStyle(color: Colors.redAccent)),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextField(codeController, 'Code'),
                      SizedBox(height: 10),
                      _buildTextField(reductionController, 'Reduction (%)', isNumber: true),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() => selectedDate = pickedDate);
                          }
                        },
                        child: AbsorbPointer(
                          child: _buildTextField(
                            TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate)),
                            'Expiration Date',
                            isReadOnly: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                    if (_validateInputs(codeController, reductionController, selectedDate)) {
                      setState(() => isLoading = true);
                      final newPromoCode = CodePromo(
                        idCode: '',
                        code: codeController.text,
                        reduction: double.parse(reductionController.text),
                        dateExpiration: selectedDate,
                      );
                      await _codePromoService.addPromoCode(newPromoCode);
                      setState(() => isLoading = false);
                      Navigator.pop(context);
                      _fetchPromoCodes();
                    }
                  },
                  child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool _validateInputs(TextEditingController codeController, TextEditingController reductionController, DateTime selectedDate) {
    if (codeController.text.isEmpty || reductionController.text.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return false;
    }
    if (double.parse(reductionController.text) > 100) {
      _showErrorDialog('Discount cannot exceed 100%');
      return false;
    }
    if (selectedDate.isBefore(DateTime.now())) {
      _showErrorDialog('Expiration date cannot be in the past');
      return false;
    }
    return true;
  }

  TextField _buildTextField(TextEditingController controller, String label, {bool isNumber = false, bool isReadOnly = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      readOnly: isReadOnly,
    );
  }

  Future<void> _deletePromoCode(String idCode) async {
    bool shouldDelete = await _showDeleteConfirmationDialog();
    if (shouldDelete) {
      try {
        await _codePromoService.deletePromoCode(idCode);
        setState(() => _promoCodes.removeWhere((code) => code.idCode == idCode));
      } catch (e) {
        print('Error deleting promo code: $e');
        _showErrorDialog('Error deleting promo code');
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Promo Code'),
          content: Text('Are you sure you want to delete this promo code?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Promo Codes'), backgroundColor: Colors.red),
      body: Stack(
        children: [
          _isLoading ? Center(child: CircularProgressIndicator()) : _buildPromoCodesList(),
          if (_isLoading) Opacity(opacity: 0.6, child: ModalBarrier(dismissible: false, color: Colors.black)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPromoCode,
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPromoCodesList() {
    return _promoCodes.isEmpty
        ? Center(child: Text('No promo codes available', style: TextStyle(fontSize: 18)))
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _promoCodes.length,
      itemBuilder: (context, index) {
        final promoCode = _promoCodes[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(promoCode.code, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discount: ${promoCode.reduction}%', style: TextStyle(color: Colors.green)),
                Text('Expires on: ${DateFormat('yyyy-MM-dd').format(promoCode.dateExpiration)}'),
              ],
            ),
            trailing: IconButton(
              onPressed: () => _deletePromoCode(promoCode.idCode),
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
