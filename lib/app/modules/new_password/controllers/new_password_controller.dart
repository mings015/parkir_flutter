import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kostparkir/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("terjadi kesalahan", "password terlalu singkat");
          }
        } catch (e) {
          Get.snackbar(
              "terjadi kesalahan", "tidak dapat membuat password baru");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Password baru tidak boleh sama");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password Harus Di isi");
    }
  }
}
