import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/base_layout.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: AppStrings.profile,
      currentIndex: 3,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;
        final student = controller.student.value;

        if (user == null) {
          return const Center(child: Text('Data pengguna tidak ditemukan'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Text(
                  user.email.isNotEmpty ? user.email[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // User Email
              Text(
                user.email,
                style: AppTextStyle.heading2,
              ),
              const SizedBox(height: 4),
              // User Role
              Text(
                controller.userRole,
                style: AppTextStyle.body2,
              ),
              const SizedBox(height: 24),
              
              // Student Information (if available)
              if (student != null)
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Siswa',
                        style: AppTextStyle.heading3,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Nama', student.name),
                      _buildInfoRow('Kelas', student.className),
                      _buildInfoRow('Semester', student.semester),
                      _buildInfoRow('Tahun Ajaran', student.academicYear.toString()),
                      _buildInfoRow('Sekolah', student.schoolName),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              
              // App Information
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang Aplikasi',
                      style: AppTextStyle.heading3,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Nama Aplikasi', AppStrings.appName),
                    _buildInfoRow('Versi', '1.0.0'),
                    _buildInfoRow('Pengembang', 'Studio Solusi Digital'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Logout Button
              AppButton(
                text: AppStrings.logout,
                onPressed: controller.logout,
                isPrimary: false,
                icon: Icons.logout,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.body2,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 