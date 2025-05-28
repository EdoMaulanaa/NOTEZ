import '../models/merit_demerit_model.dart';
import '../models/student_model.dart';
import 'storage_service.dart';
import 'student_service.dart';

class MeritDemeritService {
  final StorageService _storageService = StorageService();
  final StudentService _studentService = StudentService();
  final String _meritDemeritFile = 'merit_demerit.json';

  Future<List<MeritDemerit>> getAllMeritDemerits() async {
    final meritDemeritsData = await _storageService.readJsonList(_meritDemeritFile);
    return meritDemeritsData
        .map((data) => MeritDemerit.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  Future<List<MeritDemerit>> getMeritDemeritsByStudent(String studentId) async {
    final allMeritDemerits = await getAllMeritDemerits();
    return allMeritDemerits
        .where((meritDemerit) => meritDemerit.studentId == studentId)
        .toList();
  }

  Future<List<MeritDemerit>> getMeritDemeritsByStudentAndType(
    String studentId,
    String type,
  ) async {
    final allMeritDemerits = await getAllMeritDemerits();
    return allMeritDemerits
        .where((meritDemerit) =>
            meritDemerit.studentId == studentId && meritDemerit.type == type)
        .toList();
  }

  Future<void> addMeritDemerit(MeritDemerit meritDemerit) async {
    await _storageService.appendToJsonList(_meritDemeritFile, meritDemerit.toJson());
    
    
    final student = await _studentService.getStudent(meritDemerit.studentId);
    if (student != null) {
      int meritPoints = student.meritPoints;
      int demeritPoints = student.demeritPoints;
      
      if (meritDemerit.type == 'merit') {
        meritPoints += meritDemerit.points;
      } else if (meritDemerit.type == 'demerit') {
        demeritPoints += meritDemerit.points;
      }
      
      final updatedStudent = Student(
        id: student.id,
        name: student.name,
        className: student.className,
        semester: student.semester,
        academicYear: student.academicYear,
        schoolName: student.schoolName,
        meritPoints: meritPoints,
        demeritPoints: demeritPoints,
      );
      
      await _studentService.updateStudent(updatedStudent);
    }
  }

  Future<void> deleteMeritDemerit(String id, String studentId) async {
    final meritDemerits = await getAllMeritDemerits();
    final meritDemerit = meritDemerits.firstWhere((md) => md.id == id);
    
    meritDemerits.removeWhere((md) => md.id == id);
    final jsonList = meritDemerits.map((md) => md.toJson()).toList();
    await _storageService.writeJsonList(_meritDemeritFile, jsonList);
    
    
    final student = await _studentService.getStudent(studentId);
    if (student != null) {
      int meritPoints = student.meritPoints;
      int demeritPoints = student.demeritPoints;
      
      if (meritDemerit.type == 'merit') {
        meritPoints -= meritDemerit.points;
      } else if (meritDemerit.type == 'demerit') {
        demeritPoints -= meritDemerit.points;
      }
      
      final updatedStudent = Student(
        id: student.id,
        name: student.name,
        className: student.className,
        semester: student.semester,
        academicYear: student.academicYear,
        schoolName: student.schoolName,
        meritPoints: meritPoints,
        demeritPoints: demeritPoints,
      );
      
      await _studentService.updateStudent(updatedStudent);
    }
  }

  
  Future<void> createDefaultMeritDemerits() async {
    if (!await _storageService.fileExists(_meritDemeritFile)) {
      final now = DateTime.now();
      final defaultMeritDemerits = [
        MeritDemerit(
          id: 'MD001',
          studentId: 'S001',
          date: DateTime(now.year, now.month - 1, 15),
          type: 'merit',
          reason: 'Juara 1 Lomba Pidato Bahasa Indonesia',
          points: 30,
        ).toJson(),
        MeritDemerit(
          id: 'MD002',
          studentId: 'S001',
          date: DateTime(now.year, now.month - 1, 22),
          type: 'merit',
          reason: 'Membantu guru membersihkan kelas',
          points: 10,
        ).toJson(),
        MeritDemerit(
          id: 'MD003',
          studentId: 'S001',
          date: DateTime(now.year, now.month - 1, 25),
          type: 'merit',
          reason: 'Disiplin dalam tugas',
          points: 10,
        ).toJson(),
        MeritDemerit(
          id: 'MD004',
          studentId: 'S001',
          date: DateTime(now.year, now.month, 5),
          type: 'demerit',
          reason: 'Terlambat masuk kelas',
          points: 5,
        ).toJson(),
        MeritDemerit(
          id: 'MD005',
          studentId: 'S001',
          date: DateTime(now.year, now.month, 10),
          type: 'demerit',
          reason: 'Tidak mengerjakan PR',
          points: 5,
        ).toJson(),
      ];
      await _storageService.writeJsonList(_meritDemeritFile, defaultMeritDemerits);
    }
  }
} 