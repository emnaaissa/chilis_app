class Category {
  final String idCategorie;  // Changed type to String to match backend
  final String categorie;
  final String etat;
  final String img;

  Category({
    required this.idCategorie,
    required this.categorie,
    required this.etat,
    required this.img,
  });

  // Factory constructor to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idCategorie: json['idCategorie'],
      categorie: json['categorie'],
      etat: json['etat'],
      img: json['img'],
    );
  }

  // Convert Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'idCategorie': idCategorie,
      'categorie': categorie,
      'etat': etat,
      'img': img,
    };
  }
}
