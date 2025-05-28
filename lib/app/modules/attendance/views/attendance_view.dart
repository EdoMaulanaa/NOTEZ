import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/base_layout.dart';
import '../../../data/models/attendance_model.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: AppStrings.attendance,
      currentIndex: 3,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final student = controller.student.value;
        final attendanceList = controller.attendanceList;

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
                      'Ringkasan Kehadiran',
                      style: AppTextStyle.heading3,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAttendanceSummary(
                          'Hadir',
                          controller.totalPresent.value,
                          Colors.green,
                          Icons.check_circle,
                        ),
                        _buildAttendanceSummary(
                          'Tidak Hadir',
                          controller.totalAbsent.value,
                          Colors.red,
                          Icons.cancel,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAttendanceSummary(
                          'Terlambat',
                          controller.totalLate.value,
                          Colors.orange,
                          Icons.access_time,
                        ),
                        _buildAttendanceSummary(
                          'Sakit',
                          controller.totalSick.value,
                          Colors.blue,
                          Icons.healing,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              
              Text(
                'Riwayat Kehadiran (30 Hari Terakhir)',
                style: AppTextStyle.heading3,
              ),
              const SizedBox(height: 8),
              attendanceList.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Tidak ada data kehadiran'),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: attendanceList.length,
                      itemBuilder: (context, index) {
                        final attendance = attendanceList[index];
                        return _buildAttendanceCard(attendance);
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAttendanceSummary(
    String title,
    int count,
    Color color,
    IconData icon,
  ) {
    return Column(
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
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyle.body2,
        ),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceCard(Attendance attendance) {
    final statusText = controller.getAttendanceStatusText(attendance.status);
    final statusColor = controller.getAttendanceStatusColor(attendance.status);
    final statusIcon = controller.getAttendanceStatusIcon(attendance.status);
    
    final formattedDate = '${attendance.date.day}/${attendance.date.month}/${attendance.date.year}';
    
    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                if (attendance.note.isNotEmpty)
                  Text(
                    attendance.note,
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
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              statusText,
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