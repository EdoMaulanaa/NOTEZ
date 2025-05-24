import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/student_service.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();

  final Rx<User?> user = Rx<User?>(null);
  final Rx<Student?> student = Rx<Student?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    isLoading.value = true;
    try {
      final currentUser = await _authService.getCurrentUser();
      user.value = currentUser;
      
      if (currentUser != null && currentUser.studentId.isNotEmpty) {
        final studentData = await _studentService.getStudent(currentUser.studentId);
        student.value = studentData;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data pengguna: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String get userRole {
    if (user.value == null) return '';
    return user.value!.role == 'student' ? 'Siswa' : 'Wali Murid';
  }
} 