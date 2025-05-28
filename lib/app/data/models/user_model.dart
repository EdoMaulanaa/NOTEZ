class User {
  final String email;
  final String password;
  final String role; 
  final String studentId; 

  User({
    required this.email,
    required this.password,
    required this.role,
    this.studentId = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'student',
      studentId: json['studentId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'studentId': studentId,
    };
  }
} 