// models/client.dart
class Client {
  final String id;          // Corresponds to 'id' in backend
  final String nom;         // Corresponds to 'nom' in backend
  final String email;       // Corresponds to 'email' in backend
  final String motDePasse;  // Corresponds to 'motDePasse' in backend
  final String tel;         // Corresponds to 'tel' in backend
  final String imgClient;   // Corresponds to 'imgClient' in backend

  Client({
    required this.id,
    required this.nom,
    required this.email,
    required this.motDePasse,
    required this.tel,
    required this.imgClient,
  });

  // Factory method to create a Client instance from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      tel: json['tel'],
      imgClient: json['imgClient'],
    );
  }

  // Method to convert a Client instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'motDePasse': motDePasse,
      'tel': tel,
      'imgClient': imgClient,
    };
  }
}
