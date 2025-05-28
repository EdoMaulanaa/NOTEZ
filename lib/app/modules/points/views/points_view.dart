import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/base_layout.dart';
import '../controllers/points_controller.dart';

class PointsView extends GetView<PointsController> {
  const PointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: AppStrings.points,
      currentIndex: 2,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final student = controller.student.value;
        final merits = controller.merits;
        final demerits = controller.demerits;

        if (student == null) {
          return const Center(child: Text('Data siswa tidak ditemukan'));
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
                    Text(
                      'Ringkasan Poin',
                      style: AppTextStyle.heading3,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPointSummary(
                          'Penghargaan',
                          student.meritPoints,
                          AppColors.success,
                          Icons.star,
                        ),
                        _buildPointSummary(
                          'Pelanggaran',
                          student.demeritPoints,
                          AppColors.error,
                          Icons.warning,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              
              Text(
                'Riwayat Penghargaan',
                style: AppTextStyle.heading3,
              ),
              const SizedBox(height: 8),
              merits.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Tidak ada data penghargaan'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: merits.length,
                      itemBuilder: (context, index) {
                        final merit = merits[index];
                        return _buildPointCard(
                          merit.date,
                          merit.reason,
                          merit.points,
                          AppColors.success,
                          Icons.star,
                        );
                      },
                    ),
              
              const SizedBox(height: 24),
              
              
              Text(
                'Riwayat Pelanggaran',
                style: AppTextStyle.heading3,
              ),
              const SizedBox(height: 8),
              demerits.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Tidak ada data pelanggaran'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: demerits.length,
                      itemBuilder: (context, index) {
                        final demerit = demerits[index];
                        return _buildPointCard(
                          demerit.date,
                          demerit.reason,
                          demerit.points,
                          AppColors.error,
                          Icons.warning,
                        );
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPointSummary(
    String title,
    int points,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
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
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyle.body2,
        ),
        const SizedBox(height: 4),
        Text(
          points.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPointCard(
    DateTime date,
    String reason,
    int points,
    Color color,
    IconData icon,
  ) {
    final formattedDate = '${date.day}/${date.month}/${date.year}';
    
    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tanggal: $formattedDate',
                  style: AppTextStyle.body2,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+$points',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 