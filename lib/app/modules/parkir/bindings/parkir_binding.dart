import 'package:get/get.dart';

import '../controllers/parkir_controller.dart';

class ParkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParkirController>(
      () => ParkirController(),
    );
  }
}
