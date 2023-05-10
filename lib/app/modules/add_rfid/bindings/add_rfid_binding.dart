import 'package:get/get.dart';

import '../controllers/add_rfid_controller.dart';

class AddRfidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRfidController>(
      () => AddRfidController(),
    );
  }
}
