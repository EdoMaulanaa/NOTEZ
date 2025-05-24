class Student {
  final String id;
  final String name;
  final String className;
  final String semester;
  final int academicYear;
  final String schoolName;
  final int meritPoints;
  final int demeritPoints;

  Student({
    required this.id,
    required this.name,
    required this.className,
    required this.semester,
    required this.academicYear,
    required this.schoolName,
    this.meritPoints = 0,
    this.demeritPoints = 0,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      className: json['className'] ?? '',
      semester: json['semester'] ?? '',
      academicYear: json['academicYear'] ?? 0,
      schoolName: json['schoolName'] ?? '',
      meritPoints: json['meritPoints'] ?? 0,
      demeritPoints: json['demeritPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'className': className,
      'semester': semester,
      'academicYear': academicYear,
      'schoolName': schoolName,
      'meritPoints': meritPoints,
      'demeritPoints': demeritPoints,
    };
  }
} 