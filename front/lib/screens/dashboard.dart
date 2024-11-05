import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/app_bar.dart';
import 'categories_screen.dart';
import 'menu_items_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _currentScreen = MenuItemsScreen(); // Default screen

  void _selectScreen(String screen) {
    setState(() {
      switch (screen) {
        case 'Menu Items':
          _currentScreen = MenuItemsScreen();
          break;
        case 'Categories':
          _currentScreen = CategoriesScreen();
          break;
        default:
          _currentScreen = MenuItemsScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      drawer: Sidebar(_selectScreen),
      body: _currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _selectScreen('Menu Items');
          } else if (index == 1) {
            _selectScreen('Categories');
          }
        },
        currentIndex: _currentScreen is MenuItemsScreen ? 0 : 1,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
