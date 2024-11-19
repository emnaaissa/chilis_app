import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/client_service.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final ClientService clientService = ClientService();
  late Future<List<Client>> clients;

  @override
  void initState() {
    super.initState();
    clients = clientService.getClients(); // Fetch the client list when screen loads
  }

  Future<void> _refreshClients() async {
    setState(() {
      clients = clientService.getClients();
    });
  }

  Future<void> _deleteClient(String id) async { // Use async
    try {
      await clientService.deleteClient(id); // Await deletion
      await _refreshClients(); // Await refresh
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Client deleted successfully')),
      );
    } catch (error) {
      print('Error deleting client: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting client')),
      );
    }
  }

  void _showClientDetails(Client client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${client.nom} Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${client.nom}', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Email: ${client.email}'),
                SizedBox(height: 8),
                Text('Phone: ${client.tel}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Client>>(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final client = snapshot.data![index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(client.nom[0].toUpperCase(), style: TextStyle(color: Colors.white)),
                      ),
                      title: Text(client.nom, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(client.email),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text('Are you sure you want to delete ${client.nom}?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteClient(client.id); // Await deletion and refresh
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () {
                        _showClientDetails(client);
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
