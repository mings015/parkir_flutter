import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kostparkir/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);
        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Belum verifikasi",
                middleText:
                    "Belum verifikasi akun. lakukan verifikasi di email.",
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      isLoading.value = false;
                      Get.back();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar(
                              "Berhasil", "Email Verifikasi Sudah Dikirim");
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar("Terjadi Kesalahan",
                              "Tidak Dapat mengirim ulang");
                        }
                      },
                      child: Text("Kirim Ulang"))
                ]);
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("terjadi kesalahan", "email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("terjadi kesalahan", "password salah");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("terjadi kesalahan", "Tidak dapat login");
      }
    } else {
      Get.snackbar("terjadi kesalahan", "email password harus di isi");
    }
  }
}
