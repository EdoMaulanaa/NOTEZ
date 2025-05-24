import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/student_service.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();

  final Rx<Student?> student = Rx<Student?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
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

  void goToGrades() {
    Get.toNamed(Routes.GRADES);
  }

  void goToAttendance() {
    Get.toNamed(Routes.ATTENDANCE);
  }

  void goToPoints() {
    Get.toNamed(Routes.POINTS);
  }

  void goToRules() {
    Get.toNamed(Routes.RULES);
  }
}
