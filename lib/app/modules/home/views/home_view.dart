import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/base_layout.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: AppStrings.home,
      currentIndex: 0,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final student = controller.student.value;
        if (student == null) {
          return const Center(
            child: Text('Data siswa tidak ditemukan'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            student.name.isNotEmpty
                                ? student.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: AppTextStyle.heading2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${student.className} - ${student.semester}',
                                style: AppTextStyle.body2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                student.schoolName,
                                style: AppTextStyle.body2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPointInfo(
                          'Penghargaan',
                          student.meritPoints.toString(),
                          AppColors.success,
                        ),
                        _buildPointInfo(
                          'Pelanggaran',
                          student.demeritPoints.toString(),
                          AppColors.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Menu Utama',
                style: AppTextStyle.heading3,
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    'Nilai',
                    Icons.assignment,
                    AppColors.primary,
                    controller.goToGrades,
                  ),
                  _buildMenuCard(
                    'Absensi',
                    Icons.calendar_today,
                    Colors.orange,
                    controller.goToAttendance,
                  ),
                  _buildMenuCard(
                    'Poin',
                    Icons.star,
                    Colors.green,
                    controller.goToPoints,
                  ),
                  _buildMenuCard(
                    'Peraturan',
                    Icons.rule,
                    Colors.red,
                    controller.goToRules,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPointInfo(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.body2,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return AppCard(
      onTap: onTap,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyle.body1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
