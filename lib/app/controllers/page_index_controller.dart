import 'package:get/get.dart';
import 'package:kostparkir/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  void changePage(int i) async {
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.PARKIR);
        break;
      case 2:
        Get.offAllNamed(Routes.PROFIL);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
