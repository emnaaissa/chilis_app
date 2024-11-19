import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/client.dart';

class ClientService {
  final String baseUrl = 'http://10.0.2.2:9092/api/clients';

  Future<List<Client>> getClients() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  Future<void> deleteClient(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // 2xx responses indicate success.
      print('Client with ID $id successfully deleted. Response: ${response.body}');
    } else {
      // Log details for debugging
      print('Failed to delete client. Status code: ${response.statusCode}, Response: ${response.body}');
      throw Exception('Failed to delete client');
    }
  }

}
