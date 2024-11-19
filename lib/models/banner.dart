class AppBanner {
  final String id;  // Change to String to match Java model (idBanner)
  final String image;
  final bool etat;  // Keep the bool type for compatibility with the backend

  AppBanner({
    required this.id,
    required this.image,
    required this.etat,
  });

  factory AppBanner.fromJson(Map<String, dynamic> json) {
    return AppBanner(
      id: json['idBanner'],  // Match the backend field name
      image: json['image'],
      etat: json['etatBanner'] == true,  // Check boolean in backend (java)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBanner': id,  // Match the backend field name
      'image': image,
      'etatBanner': etat,  // Send boolean directly to backend
    };
  }
}
