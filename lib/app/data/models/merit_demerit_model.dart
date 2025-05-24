class MeritDemerit {
  final String id;
  final String studentId;
  final DateTime date;
  final String type; // 'merit' or 'demerit'
  final String reason;
  final int points;

  MeritDemerit({
    required this.id,
    required this.studentId,
    required this.date,
    required this.type,
    required this.reason,
    required this.points,
  });

  factory MeritDemerit.fromJson(Map<String, dynamic> json) {
    return MeritDemerit(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      date: DateTime.parse(json['date']),
      type: json['type'] ?? '',
      reason: json['reason'] ?? '',
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'date': date.toIso8601String(),
      'type': type,
      'reason': reason,
      'points': points,
    };
  }
} 