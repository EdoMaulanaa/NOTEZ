import '../models/student_model.dart';
import 'storage_service.dart';

class StudentService {
  final StorageService _storageService = StorageService();
  final String _studentsFile = 'students.json';

  Future<List<Student>> getAllStudents() async {
    final studentsData = await _storageService.readJsonList(_studentsFile);
    return studentsData
        .map((data) => Student.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  Future<Student?> getStudent(String id) async {
    final students = await getAllStudents();
    try {
      return students.firstWhere((student) => student.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addStudent(Student student) async {
    await _storageService.appendToJsonList(_studentsFile, student.toJson());
  }

  Future<void> updateStudent(Student student) async {
    final students = await getAllStudents();
    final index = students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      students[index] = student;
      final jsonList = students.map((s) => s.toJson()).toList();
      await _storageService.writeJsonList(_studentsFile, jsonList);
    }
  }

  Future<void> deleteStudent(String id) async {
    final students = await getAllStudents();
    students.removeWhere((student) => student.id == id);
    final jsonList = students.map((s) => s.toJson()).toList();
    await _storageService.writeJsonList(_studentsFile, jsonList);
  }

  // For demo purposes, create a default student if none exist
  Future<void> createDefaultStudent() async {
    if (!await _storageService.fileExists(_studentsFile)) {
      await _storageService.writeJsonList(_studentsFile, [
        Student(
          id: 'S001',
          name: 'Ahmad Rizki',
          className: 'IX-A',
          semester: 'Semester 1',
          academicYear: 2024,
          schoolName: 'SMP Negeri 1',
          meritPoints: 50,
          demeritPoints: 10,
        ).toJson(),
      ]);
    }
  }
} 