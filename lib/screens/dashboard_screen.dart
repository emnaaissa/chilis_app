import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'package:frontend/screens/screens.dart';

import 'categories_screen.dart';
import 'clients_screen.dart';
import 'menu_items_screen.dart'; // Assuming you have a screens.dart that imports all your screens

class DashboardScreen extends StatelessWidget {
  final Function(Screens) onSelectScreen;

  DashboardScreen({required this.onSelectScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(onSelectScreen),
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open the sidebar drawer
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(context, 'Menu Items', Icons.menu, Colors.blue, MenuItemsScreen()),
            _buildDashboardCard(context, 'Categories', Icons.category, Colors.green, CategoriesScreen()),
            _buildDashboardCard(context, 'Clients', Icons.people, Colors.orange, ClientsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Color color, Widget targetScreen) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),  // Navigate to the respective screen
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
