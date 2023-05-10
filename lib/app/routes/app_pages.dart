import 'package:get/get.dart';

import '../modules/add_rfid/bindings/add_rfid_binding.dart';
import '../modules/add_rfid/views/add_rfid_view.dart';
import '../modules/add_user/bindings/add_user_binding.dart';
import '../modules/add_user/views/add_user_view.dart';
import '../modules/all_parkir/bindings/all_parkir_binding.dart';
import '../modules/all_parkir/views/all_parkir_view.dart';
import '../modules/bukapalang/bindings/bukapalang_binding.dart';
import '../modules/bukapalang/views/bukapalang_view.dart';
import '../modules/edit_penghuni/bindings/edit_penghuni_binding.dart';
import '../modules/edit_penghuni/views/edit_penghuni_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/izin/bindings/izin_binding.dart';
import '../modules/izin/views/izin_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/parkir/bindings/parkir_binding.dart';
import '../modules/parkir/views/parkir_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/tutup_kost/bindings/tutup_kost_binding.dart';
import '../modules/tutup_kost/views/tutup_kost_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profil/bindings/update_profil_binding.dart';
import '../modules/update_profil/views/update_profil_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFIL,
      page: () => const UpdateProfilView(),
      binding: UpdateProfilBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PARKIR,
      page: () => const ParkirView(),
      binding: ParkirBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TUTUP_KOST,
      page: () => const TutupKostView(),
      binding: TutupKostBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PARKIR,
      page: () => const AllParkirView(),
      binding: AllParkirBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RFID,
      page: () => const AddRfidView(),
      binding: AddRfidBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PENGHUNI,
      page: () => const EditPenghuniView(),
      binding: EditPenghuniBinding(),
    ),
    GetPage(
      name: _Paths.IZIN,
      page: () => const IzinView(),
      binding: IzinBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.BUKAPALANG,
      page: () => const BukapalangView(),
      binding: BukapalangBinding(),
    ),
  ];
}
