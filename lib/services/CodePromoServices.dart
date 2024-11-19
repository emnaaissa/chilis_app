import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/CodePromo.dart';

class CodePromoService {
  final String _baseUrl = 'http://10.0.2.2:9092/api'; // Replace with your API base URL

  // Fetch all promo codes
  Future<List<CodePromo>> fetchPromoCodes() async {
    final response = await http.get(Uri.parse('$_baseUrl/codepromos'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => CodePromo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load promo codes');
    }
  }


  // Add a new promo code
  Future<void> addPromoCode(CodePromo codePromo) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/codepromos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(codePromo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add promo code');
    }
  }

  // Delete a promo code by ID
  Future<void> deletePromoCode(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/codepromos/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete promo code');
    }
  }
}
