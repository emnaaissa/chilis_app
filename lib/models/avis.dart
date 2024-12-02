class Avis {
  String idAvis;        // Identifiant unique de l'avis
  String clientId;      // Référence à l'ID du client
  String commentaire;   // Commentaire laissé par le client
  int note;             // Note donnée (par exemple, entre 1 et 5)
  bool validation;      // Statut de validation de l'avis

  // Constructeur
  Avis({
    required this.idAvis,
    required this.clientId,
    required this.commentaire,
    required this.note,
    required this.validation,
  });

  // Méthode pour convertir un JSON en instance de Avis
  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      idAvis: json['idAvis'] as String,
      clientId: json['clientId'] as String,
      commentaire: json['commentaire'] as String,
      note: json['note'] as int,
      validation: json['validation'] as bool,
    );
  }

  // Méthode pour convertir une instance de Avis en JSON
  Map<String, dynamic> toJson() {
    return {
      'idAvis': idAvis,
      'clientId': clientId,
      'commentaire': commentaire,
      'note': note,
      'validation': validation,
    };
  }
}
