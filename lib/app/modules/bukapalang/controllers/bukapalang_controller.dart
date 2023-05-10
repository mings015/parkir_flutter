import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class BukapalangController extends GetxController {
  var selectStatus = "".obs;

  onChangeStatus(var status) {
    selectStatus.value = status;
  }

  void bukaPalang() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("palang/");
    if (selectStatus.value == "yes") {
      ref.update({"servo": 200, "value": selectStatus.value});
    } else if (selectStatus.value == "no") {
      ref.update({"servo": 100, "value": selectStatus.value});
    } else {
      ref.update({"servo": 100, "value": "no"});
    }
    Get.back();
  }
}
