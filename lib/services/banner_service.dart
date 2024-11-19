import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../models/banner.dart';

class BannerService {
  final String baseUrl = "http://10.0.2.2:9092/api";  // Your backend URL

  // Récupérer toutes les bannières
  Future<List<AppBanner>> fetchBanners() async {
    final response = await http.get(Uri.parse('$baseUrl/banners'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AppBanner.fromJson(json)).toList();
    } else {
      throw Exception('Échec de la récupération des bannières');
    }
  }

  // Créer une nouvelle bannière
  Future<AppBanner> createBanner(File imageFile, bool etat) async {
    final uri = Uri.parse('$baseUrl/banners/create');
    final request = http.MultipartRequest('POST', uri);

    // Ajouter l'image à la requête
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      filename: basename(imageFile.path),
    ));
    request.fields['etatBanner'] = etat ? 'true' : 'false';  // Send as true/false

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return AppBanner.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Échec de la création de la bannière');
    }
  }

  // Supprimer une bannière
  Future<void> deleteBanner(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/banners/$id'));

    if (response.statusCode != 200) {
      throw Exception('Échec de la suppression de la bannière');
    }
  }

  // Mettre à jour l'état de la bannière (actif/inactif)
  Future<void> updateBannerState(String id, bool isActive) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/banners/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'etat': isActive}),
      );

      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'état de la bannière');
      }
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de l\'état de la bannière: $e');
    }
  }
}
