class CodePromo {
  final String idCode; // ID for the promo code
  final String code;
  final double reduction;
  final DateTime dateExpiration;

  CodePromo({
    required this.idCode,
    required this.code,
    required this.reduction,
    required this.dateExpiration,
  });

  // Convert from JSON (for fetching from API or database)
  factory CodePromo.fromJson(Map<String, dynamic> json) {
    return CodePromo(
      idCode: json['idCode'],  // Ensure 'idCode' matches your backend field
      code: json['code'],
      reduction: json['reduction'],
      dateExpiration: DateTime.parse(json['dateExpiration']),
    );
  }

  // Convert to JSON (for sending to the backend)
  Map<String, dynamic> toJson() {
    return {
      'idCode': idCode,
      'code': code,
      'reduction': reduction,
      'dateExpiration': dateExpiration.toIso8601String(),
    };
  }
}
