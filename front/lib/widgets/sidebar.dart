import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function(String) onSelectScreen;

  Sidebar(this.onSelectScreen);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildListTile(context, 'Menu Items', Icons.menu),
                _buildListTile(context, 'Categories', Icons.category),
                // Add more ListTiles for other screens if necessary
                Divider(), // Add a divider for better separation
                _buildListTile(context, 'Settings', Icons.settings), // Example additional item
                _buildListTile(context, 'Logout', Icons.logout), // Example logout item
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: () {
        onSelectScreen(title);
        Navigator.of(context).pop(); // Close the drawer
      },
    );
  }
}
