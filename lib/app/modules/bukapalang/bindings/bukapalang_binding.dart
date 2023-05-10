import 'package:get/get.dart';

import '../controllers/bukapalang_controller.dart';

class BukapalangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BukapalangController>(
      () => BukapalangController(),
    );
  }
}
