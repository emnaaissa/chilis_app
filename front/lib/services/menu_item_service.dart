import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_item.dart';

class MenuItemService {
  final String apiUrl = 'http://10.0.2.2:9092/api/menu';

  Future<List<MenuItem>> fetchMenuItems() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => MenuItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  Future<void> addMenuItem(MenuItem item) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?categoryId=${item.categoryId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Menu item added successfully');
      } else {
        print('Failed to add menu item: ${response.body}');
      }
    } catch (e) {
      print('Error adding menu item: $e');
    }
  }

  Future<void> updateMenuItem(MenuItem item) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${item.idItem}?categoryId=${item.categoryId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200) {
        print('Menu item updated successfully');
      } else {
        print('Failed to update menu item: ${response.body}');
      }
    } catch (e) {
      print('Error updating menu item: $e');
    }
  }

  Future<void> deleteMenuItem(int idItem) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$idItem'));

      if (response.statusCode == 200) {
        print('Menu item deleted successfully');
      } else {
        print('Failed to delete menu item: ${response.body}');
      }
    } catch (e) {
      print('Error deleting menu item: $e');
    }
  }
}
