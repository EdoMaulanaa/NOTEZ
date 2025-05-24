class SchoolRule {
  final String id;
  final String title;
  final String description;
  final int demeritPoints;

  SchoolRule({
    required this.id,
    required this.title,
    required this.description,
    required this.demeritPoints,
  });

  factory SchoolRule.fromJson(Map<String, dynamic> json) {
    return SchoolRule(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      demeritPoints: json['demeritPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'demeritPoints': demeritPoints,
    };
  }
} 