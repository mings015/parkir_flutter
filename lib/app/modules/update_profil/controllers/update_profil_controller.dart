import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

class UpdateProfilController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nohpC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  Future<void> updateProfil(String uid) async {
    if (nohpC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "nama": namaC.text,
          "nohp": nohpC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();
          data.addAll({"profile": urlImage});
        }
        await firestore.collection("penjaga").doc(uid).update(data);
        image = null;
        Get.snackbar("Berhasil", "Berhasil update profil");
      } catch (e) {
        Get.snackbar("terjadi kesalahan", "Tidak dapat update profil");
      } finally {
        isLoading.value = false;
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    update();
  }

  void deleteProfile(String uid) async {
    try {
      firestore.collection("penjaga").doc(uid).update({
        "profile": FieldValue.delete(),
      });
      Get.back();
      Get.snackbar("Berhasil", "Photo Profil berhasil di ganti");
    } catch (e) {
      Get.snackbar("terjadi kesalahan", "Tidak dapat hapus photo profil");
    } finally {
      update();
    }
  }
}
