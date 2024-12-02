import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/avis.dart';

class AvisService {
  final String baseUrl = 'http://10.0.2.2:9092/api/avis';

  // Fetch all avis without filtering by client
  Future<List<Avis>> fetchAllAvis() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((avis) => Avis.fromJson(avis)).toList();
    } else {
      throw Exception('Failed to load avis');
    }
  }

  // Update validation status of an avis
  Future<void> toggleValidation(String idAvis, bool validationStatus) async {
    final response = await http.patch( // Utilisation de PATCH au lieu de PUT
      Uri.parse('$baseUrl/$idAvis'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'validation': validationStatus}), // Envoyer uniquement le champ à modifier
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update validation status');
    }
  }


  // Delete an avis by ID
  Future<void> deleteAvis(String idAvis) async {
    final response = await http.delete(Uri.parse('$baseUrl/$idAvis'));

    // Accept 204 (No Content) as a successful response, in addition to 200
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete avis');
    }
  }


}
