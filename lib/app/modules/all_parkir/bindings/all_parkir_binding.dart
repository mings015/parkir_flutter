import 'package:get/get.dart';

import '../controllers/all_parkir_controller.dart';

class AllParkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllParkirController>(
      () => AllParkirController(),
    );
  }
}
