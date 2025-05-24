import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/student_service.dart';
import '../../../data/services/grade_service.dart';
import '../../../data/services/attendance_service.dart';
import '../../../data/services/merit_demerit_service.dart';
import '../../../data/services/school_rule_service.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService _authService = AuthService();
  final StudentService _studentService = StudentService();
  final GradeService _gradeService = GradeService();
  final AttendanceService _attendanceService = AttendanceService();
  final MeritDemeritService _meritDemeritService = MeritDemeritService();
  final SchoolRuleService _schoolRuleService = SchoolRuleService();

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Create default data for demo purposes
    await _authService.createDefaultUsers();
    await _studentService.createDefaultStudent();
    await _gradeService.createDefaultGrades();
    await _attendanceService.createDefaultAttendance();
    await _meritDemeritService.createDefaultMeritDemerits();
    await _schoolRuleService.createDefaultRules();

    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
} 