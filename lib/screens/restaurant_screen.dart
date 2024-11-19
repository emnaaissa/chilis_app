import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/restaurant_service.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantService _restaurantService = RestaurantService();
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final restaurants = await _restaurantService.fetchRestaurants();
      setState(() {
        _restaurants = restaurants;
      });
    } catch (e) {
      print('Error fetching restaurants: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addRestaurant() async {
    final localisationController = TextEditingController();
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Add Restaurant',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: localisationController,
              decoration: InputDecoration(
                labelText: 'Localisation',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: isLoading
                  ? null
                  : () async {
                setState(() => isLoading = true);
                final newRestaurant = Restaurant(
                  idResto: '',
                  localisationRestau: localisationController.text,
                  etatResto: 'open',
                );
                await _restaurantService.addRestaurant(newRestaurant);
                setState(() => isLoading = false);
                Navigator.pop(context);
                _fetchRestaurants();
              },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editRestaurant(Restaurant restaurant) async {
    final localisationController = TextEditingController(text: restaurant.localisationRestau);
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Edit Restaurant',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: localisationController,
              decoration: InputDecoration(
                labelText: 'Localisation',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: isLoading
                  ? null
                  : () async {
                setState(() => isLoading = true);
                final updatedRestaurant = Restaurant(
                  idResto: restaurant.idResto,
                  localisationRestau: localisationController.text,
                  etatResto: restaurant.etatResto,
                );
                await _restaurantService.updateRestaurant(updatedRestaurant);
                setState(() => isLoading = false);
                Navigator.pop(context);
                _fetchRestaurants();
              },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteRestaurant(String idResto) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Delete Restaurant', style: TextStyle(color: Colors.redAccent)),
          content: Text('Are you sure you want to delete this restaurant?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => Navigator.pop(context, true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _restaurantService.deleteRestaurant(idResto);
      _fetchRestaurants();
    }
  }

  Future<void> _toggleRestaurantStatus(Restaurant restaurant) async {
    final updatedRestaurant = Restaurant(
      idResto: restaurant.idResto,
      localisationRestau: restaurant.localisationRestau,
      etatResto: restaurant.etatResto == 'open' ? 'close' : 'open',
    );
    await _restaurantService.updateRestaurant(updatedRestaurant);
    _fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _restaurants.isEmpty
          ? Center(child: Text('No restaurants available', style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurants[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(restaurant.localisationRestau,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(
                restaurant.etatResto == 'open' ? 'Open' : 'Closed',
                style: TextStyle(color: restaurant.etatResto == 'open' ? Colors.green : Colors.red),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: restaurant.etatResto == 'open',
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    onChanged: (_) => _toggleRestaurantStatus(restaurant),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editRestaurant(restaurant),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteRestaurant(restaurant.idResto),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRestaurant,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
