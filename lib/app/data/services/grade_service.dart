import '../models/grade_model.dart';
import 'storage_service.dart';

class GradeService {
  final StorageService _storageService = StorageService();
  final String _gradesFile = 'grades.json';

  Future<List<Grade>> getAllGrades() async {
    final gradesData = await _storageService.readJsonList(_gradesFile);
    return gradesData
        .map((data) => Grade.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  Future<List<Grade>> getGradesByStudent(String studentId) async {
    final allGrades = await getAllGrades();
    return allGrades.where((grade) => grade.studentId == studentId).toList();
  }

  Future<List<Grade>> getGradesByStudentAndSemester(
    String studentId,
    String semester,
    int academicYear,
  ) async {
    final allGrades = await getAllGrades();
    return allGrades
        .where((grade) =>
            grade.studentId == studentId &&
            grade.semester == semester &&
            grade.academicYear == academicYear)
        .toList();
  }

  Future<Grade?> getGradeBySubject(
    String studentId,
    String subject,
    String semester,
    int academicYear,
  ) async {
    final allGrades = await getAllGrades();
    try {
      return allGrades.firstWhere((grade) =>
          grade.studentId == studentId &&
          grade.subject == subject &&
          grade.semester == semester &&
          grade.academicYear == academicYear);
    } catch (e) {
      return null;
    }
  }

  Future<void> addGrade(Grade grade) async {
    await _storageService.appendToJsonList(_gradesFile, grade.toJson());
  }

  Future<void> updateGrade(Grade grade) async {
    final grades = await getAllGrades();
    final index = grades.indexWhere((g) =>
        g.studentId == grade.studentId &&
        g.subject == grade.subject &&
        g.semester == grade.semester &&
        g.academicYear == grade.academicYear);

    if (index != -1) {
      grades[index] = grade;
      final jsonList = grades.map((g) => g.toJson()).toList();
      await _storageService.writeJsonList(_gradesFile, jsonList);
    }
  }

  Future<void> deleteGrade(
    String studentId,
    String subject,
    String semester,
    int academicYear,
  ) async {
    final grades = await getAllGrades();
    grades.removeWhere((grade) =>
        grade.studentId == studentId &&
        grade.subject == subject &&
        grade.semester == semester &&
        grade.academicYear == academicYear);

    final jsonList = grades.map((g) => g.toJson()).toList();
    await _storageService.writeJsonList(_gradesFile, jsonList);
  }

  // For demo purposes, create default grades if none exist
  Future<void> createDefaultGrades() async {
    if (!await _storageService.fileExists(_gradesFile)) {
      final defaultGrades = [
        Grade(
          studentId: 'S001',
          subject: 'Matematika',
          semester: 'Semester 1',
          academicYear: 2024,
          score: 85.0,
          grade: 'A-',
        ).toJson(),
        Grade(
          studentId: 'S001',
          subject: 'Bahasa Indonesia',
          semester: 'Semester 1',
          academicYear: 2024,
          score: 92.0,
          grade: 'A',
        ).toJson(),
        Grade(
          studentId: 'S001',
          subject: 'Bahasa Inggris',
          semester: 'Semester 1',
          academicYear: 2024,
          score: 78.0,
          grade: 'B+',
        ).toJson(),
        Grade(
          studentId: 'S001',
          subject: 'IPA',
          semester: 'Semester 1',
          academicYear: 2024,
          score: 83.0,
          grade: 'B+',
        ).toJson(),
        Grade(
          studentId: 'S001',
          subject: 'IPS',
          semester: 'Semester 1',
          academicYear: 2024,
          score: 88.0,
          grade: 'A-',
        ).toJson(),
      ];
      await _storageService.writeJsonList(_gradesFile, defaultGrades);
    }
  }
} 