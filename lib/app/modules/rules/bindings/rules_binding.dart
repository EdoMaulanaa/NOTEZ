import 'package:get/get.dart';

import '../controllers/rules_controller.dart';

class RulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RulesController());
  }
} 