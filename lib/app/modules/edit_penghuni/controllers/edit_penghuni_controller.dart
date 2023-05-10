import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPenghuniController extends GetxController {
  TextEditingController kamarC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController rfidC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  TextEditingController endKostC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseDatabase realtime = FirebaseDatabase.instance;

  final dbRef = FirebaseDatabase.instance.ref().child('penghuni');

  Future getData(String rfid) async {
    //DocumentReference docRef = firestore.collection("penghuni").doc(docID);
    DatabaseReference docRef = realtime.ref("penghuni").child(rfid);
    print(docRef.get());
    return docRef.get();
  }

  void editRfid(String docID) async {
    DocumentReference rfid = firestore.collection("penghuni").doc(docID);
    if (kamarC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        nohpC.text.isNotEmpty &&
        rfidC.text.isNotEmpty &&
        kamarC.text.length == 2 &&
        statusC.text.isNotEmpty &&
        endKostC.text.isNotEmpty) {
      var hasil = await rfid.update({
        "kamar": kamarC.text,
        "namaP": namaC.text,
        "nohpP": nohpC.text,
        "rfid": rfidC.text,
        "status": statusC.text,
        "berakhir": endKostC.text,
        "createAt": DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil mengedit penghuni kost");
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua Field Harus di isi");
    }
  }

  void delete(String docID) async {
    DocumentReference docRef = firestore.collection("penghuni").doc(docID);
    await docRef.delete();
    // try {
    //   await firestore.collection("penghuni").doc(docID).delete();
    //   return {
    //     "error": false,
    //     "massage": "Berhasil delete data",
    //   };
    // } catch (e) {
    //   return {
    //     "error": true,
    //     "massage": "tidak dapat delete data",
    //   };
    // }
  }
}
