class Athlete {
  final String id;
  final String name;
  final String email;
  final List<Map<String, String>> prs;
  final List<Map<String, String>> recentWorkouts;

  Athlete({
    required this.id,
    required this.name,
    required this.email,
    required this.prs,
    required this.recentWorkouts,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      prs: List<Map<String, String>>.from(json['prs'].map((pr) => Map<String, String>.from(pr))),
      recentWorkouts: List<Map<String, String>>.from(json['recentWorkouts'].map((workout) => Map<String, String>.from(workout))),
    );
  }
}
