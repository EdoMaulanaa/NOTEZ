class Grade {
  final String studentId;
  final String subject;
  final String semester;
  final int academicYear;
  final double score;
  final String grade; 

  Grade({
    required this.studentId,
    required this.subject,
    required this.semester,
    required this.academicYear,
    required this.score,
    required this.grade,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      studentId: json['studentId'] ?? '',
      subject: json['subject'] ?? '',
      semester: json['semester'] ?? '',
      academicYear: json['academicYear'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
      grade: json['grade'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'subject': subject,
      'semester': semester,
      'academicYear': academicYear,
      'score': score,
      'grade': grade,
    };
  }
} 