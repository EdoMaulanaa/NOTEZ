import 'package:get/get.dart';
import '../../../data/models/merit_demerit_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/merit_demerit_service.dart';
import '../../../data/services/student_service.dart';

class PointsController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();
  final MeritDemeritService _meritDemeritService = MeritDemeritService();

  final Rx<Student?> student = Rx<Student?>(null);
  final RxList<MeritDemerit> merits = <MeritDemerit>[].obs;
  final RxList<MeritDemerit> demerits = <MeritDemerit>[].obs;
  final RxBool isLoading = true.obs;

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
            await _loadMeritsDemerits(studentId);
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

  Future<void> _loadMeritsDemerits(String studentId) async {
    try {
      final meritList = await _meritDemeritService.getMeritDemeritsByStudentAndType(
        studentId,
        'merit',
      );
      merits.assignAll(meritList);

      final demeritList = await _meritDemeritService.getMeritDemeritsByStudentAndType(
        studentId,
        'demerit',
      );
      demerits.assignAll(demeritList);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data poin: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 