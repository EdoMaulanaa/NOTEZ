import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/attendance_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/services/attendance_service.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/student_service.dart';

class AttendanceController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();
  final AttendanceService _attendanceService = AttendanceService();

  final Rx<Student?> student = Rx<Student?>(null);
  final RxList<Attendance> attendanceList = <Attendance>[].obs;
  final RxBool isLoading = true.obs;
  
  // Statistics
  final RxInt totalPresent = 0.obs;
  final RxInt totalAbsent = 0.obs;
  final RxInt totalLate = 0.obs;
  final RxInt totalSick = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    try {
      final currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        final studentId = currentUser.role == 'student'
            ? currentUser.studentId
            : currentUser.studentId;

        if (studentId.isNotEmpty) {
          final studentData = await _studentService.getStudent(studentId);
          student.value = studentData;
          
          if (studentData != null) {
            await _loadAttendance(studentId);
            _calculateStatistics();
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadAttendance(String studentId) async {
    try {
      // Get 30 days of attendance
      final now = DateTime.now();
      final startDate = now.subtract(const Duration(days: 30));
      
      final attendanceRecords = await _attendanceService.getAttendanceByStudentAndDateRange(
        studentId,
        startDate,
        now,
      );
      
      // Sort by date (newest first)
      attendanceRecords.sort((a, b) => b.date.compareTo(a.date));
      attendanceList.assignAll(attendanceRecords);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data absensi: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _calculateStatistics() {
    int present = 0;
    int absent = 0;
    int late = 0;
    int sick = 0;
    
    for (final attendance in attendanceList) {
      switch (attendance.status) {
        case 'present':
          present++;
          break;
        case 'absent':
          absent++;
          break;
        case 'late':
          late++;
          break;
        case 'sick':
          sick++;
          break;
      }
    }
    
    totalPresent.value = present;
    totalAbsent.value = absent;
    totalLate.value = late;
    totalSick.value = sick;
  }

  String getAttendanceStatusText(String status) {
    switch (status) {
      case 'present':
        return 'Hadir';
      case 'absent':
        return 'Tidak Hadir';
      case 'late':
        return 'Terlambat';
      case 'sick':
        return 'Sakit';
      default:
        return 'Tidak Diketahui';
    }
  }

  Color getAttendanceStatusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'sick':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData getAttendanceStatusIcon(String status) {
    switch (status) {
      case 'present':
        return Icons.check_circle;
      case 'absent':
        return Icons.cancel;
      case 'late':
        return Icons.access_time;
      case 'sick':
        return Icons.healing;
      default:
        return Icons.help;
    }
  }
} 