import 'package:flutter/material.dart';
import '../models/avis.dart';
import '../services/avis_service.dart';

class AvisScreen extends StatefulWidget {
  @override
  _AvisScreenState createState() => _AvisScreenState();
}

class _AvisScreenState extends State<AvisScreen> {
  final AvisService _avisService = AvisService();
  List<Avis> _avisList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAvis();
  }

  Future<void> _fetchAvis() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final avisList = await _avisService.fetchAllAvis();
      setState(() {
        _avisList = avisList;
      });
    } catch (e) {
      print('Error fetching avis: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch reviews')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAvis(String idAvis) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer l\'avis'),
        content: Text('Êtes-vous sûr de vouloir supprimer cet avis ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _avisService.deleteAvis(idAvis);
        await _fetchAvis(); // Refresh the list after deletion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Avis supprimé avec succès')),
        );
      } catch (e) {
        print('Erreur lors de la suppression de l\'avis : $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la suppression de l\'avis')),
        );
      }
    }
  }



  Future<void> _toggleValidation(Avis avis) async {
    try {
      await _avisService.toggleValidation(avis.idAvis, !avis.validation);
      setState(() {
        avis.validation = !avis.validation;
      });
    } catch (e) {
      print('Error updating validation status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update validation status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avis'),
        backgroundColor: Colors.redAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _avisList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.reviews, size: 50, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'No reviews available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _avisList.length,
        itemBuilder: (context, index) {
          final avis = _avisList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: avis.validation ? Colors.green : Colors.red,
                child: Icon(
                  avis.validation ? Icons.check : Icons.close,
                  color: Colors.white,
                ),
              ),
              title: Text(
                avis.commentaire,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rating: ${avis.note}'),
                      Row(
                        children: [
                          Text(
                            'Validated: ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Switch(
                            value: avis.validation,
                            onChanged: (value) => _toggleValidation(avis),
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteAvis(avis.idAvis),
              ),
            ),
          );
        },
      ),
    );
  }
}
