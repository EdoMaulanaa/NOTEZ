import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Email tidak valid';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }
  
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    isLoading.value = true;
    
    try {
      final success = await _authService.login(
        emailController.text.trim(),
        passwordController.text,
      );
      
      if (success) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'Login Gagal',
          'Email atau password salah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
} 