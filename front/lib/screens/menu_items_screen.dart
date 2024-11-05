import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/menu_item_service.dart';
import 'package:http/http.dart' as http; // Add this import for HTTP requests
import 'dart:convert'; // Add this import for JSON decoding

class MenuItemsScreen extends StatefulWidget {
  @override
  _MenuItemsScreenState createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  final MenuItemService _menuItemService = MenuItemService();
  List<MenuItem> _menuItems = [];
  List<String> _categories = []; // Assuming you'll fetch categories as well
  String _selectedCategory = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
    _fetchCategories(); // Fetch categories if needed
  }

  Future<void> _fetchMenuItems() async {
    setState(() => _isLoading = true);
    try {
      final items = await _menuItemService.fetchMenuItems();
      print('Fetched items: $items'); // Debug log to check data received
      setState(() {
        _menuItems = items;
      });
    } catch (e) {
      print('Error fetching items: $e'); // Debug log for errors
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchCategories() async {
    setState(() => _isLoading = true); // Set loading state
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:9092/api/categories')); // Replace with your API URL
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          _categories = jsonResponse.map((category) => category['nomCategorie'] as String).toList(); // Adjust based on your JSON structure
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      setState(() => _isLoading = false); // Reset loading state
    }
  }

  Future<void> _addOrEditMenuItem({MenuItem? menuItem}) async {
    final nameController = TextEditingController(text: menuItem?.nom ?? '');
    final descriptionController = TextEditingController(text: menuItem?.description ?? '');
    final priceController = TextEditingController(text: menuItem?.prix.toString() ?? '0.0');

    if (menuItem != null) {
      _selectedCategory = menuItem.categoryName; // Initialize selected category when editing
    }

    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(menuItem == null ? 'Add Menu Item' : 'Edit Menu Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                  TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
                  TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
                  // Dropdown for category selection
                  DropdownButton<String>(
                    value: _selectedCategory.isEmpty ? null : _selectedCategory,
                    hint: Text('Select Category'),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue ?? '';
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(
                  onPressed: isLoading ? null : () async {
                    setState(() => isLoading = true);
                    final newItem = MenuItem(
                      idItem: menuItem?.idItem ?? 0,
                      nom: nameController.text,
                      description: descriptionController.text,
                      prix: double.tryParse(priceController.text) ?? 0.0, // Safely parse price
                      image: '', // Placeholder for image URL
                      categoryId: _categories.indexOf(_selectedCategory) + 1, // Use the index as ID (1-based)
                      categoryName: _selectedCategory, // Pass the selected category name
                    );

                    if (menuItem == null) {
                      await _menuItemService.addMenuItem(newItem);
                    } else {
                      await _menuItemService.updateMenuItem(newItem);
                    }

                    setState(() => isLoading = false);
                    Navigator.pop(context);
                    _fetchMenuItems();
                  },
                  child: isLoading ? CircularProgressIndicator() : Text(menuItem == null ? 'Add' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteMenuItem(int idItem) async {
    await _menuItemService.deleteMenuItem(idItem);
    _fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Menu Items')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _categories.isEmpty // Check if categories are loaded
          ? Center(child: Text('No categories available.'))
          : ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = _menuItems[index];
          return ListTile(
            title: Text(menuItem.nom),
            subtitle: Text('${menuItem.description} - \$${menuItem.prix}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () => _addOrEditMenuItem(menuItem: menuItem)),
                IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteMenuItem(menuItem.idItem)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditMenuItem(),
        child: Icon(Icons.add),
      ),
    );
  }
}
