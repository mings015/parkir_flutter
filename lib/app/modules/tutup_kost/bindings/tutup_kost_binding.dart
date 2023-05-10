import 'package:get/get.dart';

import '../controllers/tutup_kost_controller.dart';

class TutupKostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TutupKostController>(
      () => TutupKostController(),
    );
  }
}
