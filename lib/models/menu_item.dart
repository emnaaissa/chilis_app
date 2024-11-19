class MenuItem {
  final String idItem;
  final String nom;
  final String description;
  final double prix;
  String image;
  final String categoryId;

  MenuItem({
    required this.idItem,
    required this.nom,
    required this.description,
    required this.prix,
    required this.image,
    required this.categoryId,
  });

  @override
  String toString() {
    return 'MenuItem(name: $nom, description: $description, price: $prix, image: $image, categoryId: $categoryId)';
  }

  // Factory method to create an instance from JSON
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      idItem: json['idItem'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      description: json['description'] as String? ?? '',
      prix: (json['prix'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
    'idItem': idItem,
    'nom': nom,
    'description': description,
    'prix': prix,
    'image': image,
    'categoryId': categoryId,
  };
}
