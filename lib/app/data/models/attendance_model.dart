class Attendance {
  final String studentId;
  final DateTime date;
  final String status; // 'present', 'absent', 'late', 'sick'
  final String note;

  Attendance({
    required this.studentId,
    required this.date,
    required this.status,
    this.note = '',
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      studentId: json['studentId'] ?? '',
      date: DateTime.parse(json['date']),
      status: json['status'] ?? '',
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'date': date.toIso8601String(),
      'status': status,
      'note': note,
    };
  }
} 