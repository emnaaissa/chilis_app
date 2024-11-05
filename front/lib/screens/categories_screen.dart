import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
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

  Future<void> _addCategory() async {
    final nameController = TextEditingController();
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Category'),
              content: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() => isLoading = true);
                    final newCategory = Category(
                      id: 0,
                      name: nameController.text,
                    );
                    await _categoryService.addCategory(newCategory);
                    setState(() => isLoading = false);
                    Navigator.pop(context);
                    _fetchCategories();
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text('Add'),
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
        title: Text('Categories'),
      ),
      body: _categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                category.name ?? 'Unnamed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editCategory(category),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCategory(category.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _editCategory(Category category) async {
    // Edit logic here
  }

  Future<void> _deleteCategory(int id) async {
    // Delete logic here
  }
}
