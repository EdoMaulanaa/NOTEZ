import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'N',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    AppStrings.appName,
                    style: AppTextStyle.heading1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  const Text(
                    'Aplikasi Pemantauan Akademik Siswa',
                    style: AppTextStyle.body2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  
                  AppTextField(
                    label: AppStrings.email,
                    hint: 'Masukkan email anda',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  
                  Obx(() => AppTextField(
                        label: AppStrings.password,
                        hint: 'Masukkan password anda',
                        controller: controller.passwordController,
                        obscureText: controller.obscurePassword.value,
                        prefixIcon: Icons.lock,
                        suffixIcon: controller.obscurePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onSuffixIconPressed: controller.togglePasswordVisibility,
                        validator: controller.validatePassword,
                      )),
                  const SizedBox(height: 24),
                  
                  Obx(() => AppButton(
                        text: AppStrings.login,
                        onPressed: controller.login,
                        isLoading: controller.isLoading.value,
                      )),
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Demo Credentials:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email: student@example.com\nPassword: password',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 