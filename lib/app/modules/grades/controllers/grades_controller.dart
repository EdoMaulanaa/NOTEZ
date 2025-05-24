import 'package:get/get.dart';
import '../../../data/models/grade_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/grade_service.dart';
import '../../../data/services/student_service.dart';

class GradesController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();
  final GradeService _gradeService = GradeService();

  final Rx<Student?> student = Rx<Student?>(null);
  final RxList<Grade> grades = <Grade>[].obs;
  final RxBool isLoading = true.obs;
  final RxString currentSemester = ''.obs;

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
            currentSemester.value = studentData.semester;
            await _loadGrades(studentId, studentData.semester, studentData.academicYear);
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

  Future<void> _loadGrades(String studentId, String semester, int academicYear) async {
    try {
      final studentGrades = await _gradeService.getGradesByStudentAndSemester(
        studentId,
        semester,
        academicYear,
      );
      grades.assignAll(studentGrades);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat nilai: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  double calculateAverage() {
    if (grades.isEmpty) return 0;
    final sum = grades.fold<double>(0, (sum, grade) => sum + grade.score);
    return sum / grades.length;
  }

  String getLetterGrade(double score) {
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    return 'E';
  }
} 