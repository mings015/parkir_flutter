import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRfidController extends GetxController {
  TextEditingController kamarC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController rfidC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  TextEditingController endKostC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseDatabase realtime = FirebaseDatabase.instance;

  //FirebaseApp kostparkir = Firebase.app('kostparkir');
  //FirebaseDatabase database = FirebaseDatabase.instanceFor(app: kostparkir,databaseURL: "https://kostparkir-default-rtdb.asia-southeast1.firebasedatabase.app/");

  var selectStatus = "".obs;

  onChangeStatus(var status) {
    selectStatus.value = status;
  }

  void addRfid() async {
    //DatabaseReference ref = realtime.ref();
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("penghuni/").child(rfidC.text);

    //CollectionReference rfid = firestore.collection("penghuni");
    if (kamarC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        nohpC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        rfidC.text.isNotEmpty &&
        kamarC.text.length == 2 &&
        selectStatus.value.isNotEmpty &&
        endKostC.text.isNotEmpty) {
      await ref.set({
        "kamar": kamarC.text,
        "nama": namaC.text,
        "nohp": nohpC.text,
        "email": emailC.text,
        "rfid": rfidC.text,
        "status": selectStatus.value,
        "berakhir": endKostC.text,
        "createAt": DateTime.now().toIso8601String(),
      });
      // await ref.update({});
      // await firestore.collection("penghuni").doc(hasil.id).update({
      //   "penghuniId": hasil.id,
      // });
      Get.back();
      Get.snackbar("Berhasil", "Berhasil menambahkan penghuni kost");
    } else {
      Get.snackbar("Terjadi Kesalahan",
          "Semua Field Harus di isi dan nomor kamar harus 2 angka (01)");
    }

    // CollectionReference rfid = firestore.collection("penghuni");
    // if (kamarC.text.isNotEmpty &&
    //     namaC.text.isNotEmpty &&
    //     nohpC.text.isNotEmpty &&
    //     emailC.text.isNotEmpty &&
    //     rfidC.text.isNotEmpty &&
    //     kamarC.text.length == 2 &&
    //     statusC.text.isNotEmpty &&
    //     endKostC.text.isNotEmpty) {
    //   var hasil = await rfid.add({
    //     "kamar": kamarC.text,
    //     "namaP": namaC.text,
    //     "nohpP": nohpC.text,
    //     "email": emailC.text,
    //     "rfid": rfidC.text,
    //     "status": statusC.text,
    //     "berakhir": endKostC.text,
    //     "createAt": DateTime.now().toIso8601String(),
    //   });
    //   await firestore.collection("penghuni").doc(hasil.id).update({
    //     "penghuniId": hasil.id,
    //   });
    //   Get.back();
    //   Get.snackbar("Berhasil", "Berhasil menambahkan penghuni kost");
    // } else {
    //   Get.snackbar("Terjadi Kesalahan",
    //       "Semua Field Harus di isi dan nomor kamar harus 2 angka (01)");
    // }
  }
}
