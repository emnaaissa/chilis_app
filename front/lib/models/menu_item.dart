class MenuItem {
  final int idItem;
  final String nom;
  final String description;
  final double prix;
  final String image;
  final int categoryId;
  final String categoryName; // Add this line

  MenuItem({
    required this.idItem,
    required this.nom,
    required this.description,
    required this.prix,
    required this.image,
    required this.categoryId,
    required this.categoryName, // Add this line
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      idItem: json['idItem'] as int? ?? 0,
      nom: json['nom'] as String? ?? '',
      description: json['description'] as String? ?? '',
      prix: (json['prix'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      categoryId: json['category']?['idCategorie'] as int? ?? 0,
      categoryName: json['category']?['nomCategorie'] as String? ?? '', // This should remain
    );
  }

  Map<String, dynamic> toJson() => {
    'idItem': idItem,
    'nom': nom,
    'description': description,
    'prix': prix,
    'image': image,
    'categoryId': categoryId, // Assuming categoryId is expected as a direct field
  };

}
