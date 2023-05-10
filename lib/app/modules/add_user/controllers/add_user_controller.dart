import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddUser = false.obs;
  TextEditingController nohpC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesTambahPenjaga() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddUser.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential penjagaCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);

        UserCredential penjagaCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "password");
        if (penjagaCredential.user != null) {
          String uid = penjagaCredential.user!.uid;
          firestore.collection("penjaga").doc(uid).set({
            "nohp": nohpC.text,
            "nama": namaC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "penjaga",
            "createAt": DateTime.now().toIso8601String()
          });

          await penjagaCredential.user!.sendEmailVerification();

          await auth.signOut();
          UserCredential penjagaCredentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil Menambahkan Penjaga");
        }
        isLoadingAddUser.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddUser.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password Terlalu Singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Email Sudah Terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi kesalahan", "Admin tidak dapat login password salah");
        } else {
          Get.snackbar("Terjadi kesalahan", "${e.code}");
        }
      } catch (e) {
        isLoadingAddUser.value = false;
        Get.snackbar(
            "Terjadi Kesalahan", "Tidak dapat menambahkan Penjaga Kost");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Password Harus Di isi");
    }
  }

  Future<void> addUser() async {
    if (nohpC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
          title: "Validasi Admin",
          content: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text("Masukkan password untuk validasi admin"),
              SizedBox(height: 10),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (isLoadingAddUser.isFalse) {
                    await prosesTambahPenjaga();
                  }

                  isLoading.value = false;
                },
                child: Text(
                    isLoadingAddUser.isFalse ? "Tambah Penjaga" : "Loading.. "),
              ),
            ),
          ]);
    } else {
      Get.snackbar("Terjadi Kesalahan", "Field Tidak Boleh Ada Yang Kosong");
    }
  }
}
