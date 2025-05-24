import 'package:get/get.dart';
import '../../../data/models/school_rule_model.dart';
import '../../../data/services/school_rule_service.dart';

class RulesController extends GetxController {
  final SchoolRuleService _schoolRuleService = SchoolRuleService();

  final RxList<SchoolRule> rules = <SchoolRule>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRules();
  }

  Future<void> _loadRules() async {
    isLoading.value = true;
    try {
      final allRules = await _schoolRuleService.getAllRules();
      rules.assignAll(allRules);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat peraturan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
} 