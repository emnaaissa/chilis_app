class Restaurant {
  final String idResto; // Updated to String to match Firebase ID type
  final String localisationRestau;
  final String etatResto; // "open" or "close"

  Restaurant({
    required this.idResto,
    required this.localisationRestau,
    required this.etatResto,
  });

  // Factory constructor to create a Restaurant object from JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      idResto: json['idResto'],
      localisationRestau: json['localisationRestau'],
      etatResto: json['etatResto'],
    );
  }

  // Convert Restaurant object to JSON
  Map<String, dynamic> toJson() {
    return {
      'idResto': idResto,
      'localisationRestau': localisationRestau,
      'etatResto': etatResto,
    };
  }
}
