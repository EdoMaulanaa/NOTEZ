import 'package:get/get.dart';

import '../controllers/points_controller.dart';

class PointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PointsController());
  }
} 