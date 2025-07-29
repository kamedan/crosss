class WOD {
  final String name;
  final String description;
  final String type;
  final int timeCapMinutes;
  final List<String> movements;
  final String warmUp;

  WOD({
    required this.name,
    required this.description,
    required this.type,
    required this.timeCapMinutes,
    required this.movements,
    required this.warmUp,
  });

  factory WOD.fromJson(Map<String, dynamic> json) {
    return WOD(
      name: json['name'],
      description: json['description'],
      type: json['type'],
      timeCapMinutes: json['timeCapMinutes'],
      movements: List<String>.from(json['movements']),
      warmUp: json['warmUp'],
    );
  }
}
