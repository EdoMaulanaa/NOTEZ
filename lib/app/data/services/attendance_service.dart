import '../models/attendance_model.dart';
import 'storage_service.dart';

class AttendanceService {
  final StorageService _storageService = StorageService();
  final String _attendanceFile = 'attendance.json';

  Future<List<Attendance>> getAllAttendance() async {
    final attendanceData = await _storageService.readJsonList(_attendanceFile);
    return attendanceData
        .map((data) => Attendance.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  Future<List<Attendance>> getAttendanceByStudent(String studentId) async {
    final allAttendance = await getAllAttendance();
    return allAttendance
        .where((attendance) => attendance.studentId == studentId)
        .toList();
  }

  Future<List<Attendance>> getAttendanceByStudentAndDateRange(
    String studentId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allAttendance = await getAllAttendance();
    return allAttendance
        .where((attendance) =>
            attendance.studentId == studentId &&
            attendance.date.isAfter(startDate.subtract(Duration(days: 1))) &&
            attendance.date.isBefore(endDate.add(Duration(days: 1))))
        .toList();
  }

  Future<Attendance?> getAttendanceByDate(
    String studentId,
    DateTime date,
  ) async {
    final allAttendance = await getAllAttendance();
    try {
      return allAttendance.firstWhere((attendance) =>
          attendance.studentId == studentId &&
          attendance.date.year == date.year &&
          attendance.date.month == date.month &&
          attendance.date.day == date.day);
    } catch (e) {
      return null;
    }
  }

  Future<void> addAttendance(Attendance attendance) async {
    await _storageService.appendToJsonList(_attendanceFile, attendance.toJson());
  }

  Future<void> updateAttendance(Attendance attendance) async {
    final attendances = await getAllAttendance();
    final index = attendances.indexWhere((a) =>
        a.studentId == attendance.studentId &&
        a.date.year == attendance.date.year &&
        a.date.month == attendance.date.month &&
        a.date.day == attendance.date.day);

    if (index != -1) {
      attendances[index] = attendance;
      final jsonList = attendances.map((a) => a.toJson()).toList();
      await _storageService.writeJsonList(_attendanceFile, jsonList);
    }
  }

  Future<void> deleteAttendance(
    String studentId,
    DateTime date,
  ) async {
    final attendances = await getAllAttendance();
    attendances.removeWhere((attendance) =>
        attendance.studentId == studentId &&
        attendance.date.year == date.year &&
        attendance.date.month == date.month &&
        attendance.date.day == date.day);

    final jsonList = attendances.map((a) => a.toJson()).toList();
    await _storageService.writeJsonList(_attendanceFile, jsonList);
  }

  
  Future<void> createDefaultAttendance() async {
    if (!await _storageService.fileExists(_attendanceFile)) {
      final now = DateTime.now();
      final defaultAttendance = [
        Attendance(
          studentId: 'S001',
          date: DateTime(now.year, now.month, now.day - 5),
          status: 'present',
        ).toJson(),
        Attendance(
          studentId: 'S001',
          date: DateTime(now.year, now.month, now.day - 4),
          status: 'present',
        ).toJson(),
        Attendance(
          studentId: 'S001',
          date: DateTime(now.year, now.month, now.day - 3),
          status: 'sick',
          note: 'Flu with doctor\'s note',
        ).toJson(),
        Attendance(
          studentId: 'S001',
          date: DateTime(now.year, now.month, now.day - 2),
          status: 'sick',
          note: 'Flu with doctor\'s note',
        ).toJson(),
        Attendance(
          studentId: 'S001',
          date: DateTime(now.year, now.month, now.day - 1),
          status: 'present',
        ).toJson(),
      ];
      await _storageService.writeJsonList(_attendanceFile, defaultAttendance);
    }
  }
} 