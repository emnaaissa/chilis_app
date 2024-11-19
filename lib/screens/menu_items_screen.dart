import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/menu_item.dart';
import '../services/menu_item_service.dart';
import '../services/category_service.dart';
import 'image_upload_screen.dart';  // Import the ImageUploadScreen

class MenuItemsScreen extends StatefulWidget {
  @override
  _MenuItemsScreenState createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  final MenuItemService _menuItemService = MenuItemService();
  final CategoryService _categoryService = CategoryService();
  List<MenuItem> _menuItems = [];
  List<Category> _categories = [];
  String _selectedCategory = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
    _fetchCategories();
  }

  Future<void> _fetchMenuItems() async {
    setState(() => _isLoading = true);
    try {
      final items = await _menuItemService.fetchMenuItems();
      setState(() {
        _menuItems = items;
      });
    } catch (e) {
      print('Error fetching items: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await _categoryService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> _deleteMenuItem(String idItem) async {
    try {
      await _menuItemService.deleteMenuItem(idItem);
      _fetchMenuItems(); // Refresh the menu items list after deletion
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> _addOrEditMenuItem({MenuItem? menuItem}) async {
    final nameController = TextEditingController(text: menuItem?.nom ?? '');
    final descriptionController = TextEditingController(text: menuItem?.description ?? '');
    final priceController = TextEditingController(text: menuItem?.prix?.toString() ?? '0.0');
    String selectedCategoryId = menuItem?.categoryId ?? '';
    String? imageUrl = menuItem?.image ?? ''; // Set default if null

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(menuItem == null ? 'Add Menu Item' : 'Edit Menu Item'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCategoryId.isEmpty ? null : selectedCategoryId,
                      hint: Text('Select Category'),
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.idCategorie,
                          child: Text(category.categorie),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategoryId = newValue!;
                        });
                      },
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final uploadedImageUrl = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ImageUploadScreen(
                              onImageUploaded: (url) {
                                setState(() {
                                  imageUrl = url;  // Set the image URL
                                });
                              },
                            ),
                          ),
                        );
                        if (uploadedImageUrl != null) {
                          setState(() {
                            imageUrl = uploadedImageUrl;
                          });
                        }
                      },
                      icon: Icon(Icons.upload_file),
                      label: Text('Upload Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final newItem = MenuItem(
                      idItem: menuItem?.idItem ?? '',
                      nom: nameController.text,
                      description: descriptionController.text,
                      prix: double.tryParse(priceController.text) ?? 0.0,
                      image: imageUrl ?? '', // Ensure the image URL is stored correctly
                      categoryId: selectedCategoryId,
                    );

                    if (menuItem == null) {
                      await _menuItemService.addMenuItem(newItem);
                    } else {
                      await _menuItemService.updateMenuItem(newItem);
                    }
                    Navigator.pop(context);
                    _fetchMenuItems(); // Refresh after saving the menu item
                  },
                  child: Text(menuItem == null ? 'Add' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Menu Items'),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = _menuItems[index];
          final category = _categories.firstWhere(
                (category) => category.idCategorie == menuItem.categoryId,
            orElse: () => Category(idCategorie: '0', categorie: 'Unknown', etat: 'inactive', img: ''),
          );

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: menuItem.image.isNotEmpty
                  ? Image.network(menuItem.image, width: 50, height: 50, fit: BoxFit.cover)
                  : Icon(Icons.image, size: 50),
              title: Text(menuItem.nom),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menuItem.description),
                  SizedBox(height: 4),
                  Text('Price: \$${menuItem.prix}'),
                  Text('Category: ${category.categorie}'),
                ],
              ),
              trailing: Wrap(
                spacing: 8,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _addOrEditMenuItem(menuItem: menuItem),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMenuItem(menuItem.idItem),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _addOrEditMenuItem(),
        child: Icon(Icons.add),
      ),
    );
  }
}
