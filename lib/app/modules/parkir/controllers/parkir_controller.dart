import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class ParkirController extends GetxController {
  TextEditingController kamarC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController nohpC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController rfidC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  TextEditingController endKostC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var selectStatus = "".obs;

  onChangeStatus(var status) {
    selectStatus.value = status;
  }

  RxString search = RxString('');
  void usernameChanged(String val) {
    search.value = val;
  }

  //TextEditingController searchobs = "".obs;
  final TextEditingController searchC = TextEditingController();
  onChangeSearch(search) {
    searchC.value;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamRfid() async* {
    yield* firestore.collection("penghuni").orderBy("kamar").snapshots();
  }

  Future<void> showDialogEdit(
      String kamar,
      String nama,
      String nohp,
      String email,
      String rfid,
      String status,
      String berakhir,
      BuildContext context) async {
    kamarC.text = kamar;
    namaC.text = nama;
    nohpC.text = nohp;
    emailC.text = email;
    rfidC.text = rfid;
    selectStatus.value = status;
    endKostC.text = berakhir;
    return showDialog<void>(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autocorrect: false,
                    controller: kamarC,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: "Nomor kamar",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: namaC,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: nohpC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Nomor HP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: emailC,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: rfidC,
                    decoration: const InputDecoration(
                      labelText: "Nomor RFID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    //padding: EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Status Kartu:"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Radio(
                          value: "yes",
                          groupValue: selectStatus.value,
                          onChanged: (value) {
                            onChangeStatus(value);
                            print(value);
                          })),
                      Text("Aktif"),
                      Obx(() => Radio(
                          value: "no",
                          groupValue: selectStatus.value,
                          onChanged: (value) {
                            onChangeStatus(value);
                            print(value);
                          })),
                      Text("Non Aktif"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: endKostC,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Tanggal berakhirnya kost",
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2101),
                          selectableDayPredicate: (day) {
                            if ((day.isBefore(
                                DateTime.now().subtract(Duration(days: 2))))) {
                              return false;
                            }

                            return true;
                          });
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat("yyyy-MM-dd").format(pickedDate);
                        endKostC.text = formattedDate.toString();
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    editRfid(rfid);
                  },
                  child: Text("Update"))
            ],
          );
        });
  }

  void editRfid(String rfid) async {
    final ref = FirebaseDatabase.instance.ref('penghuni');
    //DocumentReference rfid = firestore.collection("penghuni").doc(docID);
    if (kamarC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        nohpC.text.isNotEmpty &&
        rfidC.text.isNotEmpty &&
        kamarC.text.length == 2 &&
        selectStatus.value.isNotEmpty &&
        endKostC.text.isNotEmpty) {
      var hasil = await ref.child(rfid).update({
        "kamar": kamarC.text,
        "nama": namaC.text,
        "nohp": nohpC.text,
        "email": emailC.text,
        "rfid": rfidC.text,
        "status": selectStatus.value,
        "berakhir": endKostC.text,
        "createAt": DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil mengedit penghuni kost");
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua Field Harus di isi");
    }
  }

  void delete(String docID) {
    DocumentReference docRef = firestore.collection("penghuni").doc(docID);
    try {
      Get.defaultDialog(
        title: "Delete data",
        middleText: "yakin hapus data ini?",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "No",
      );
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Tidak berhasil menghapus data");
    }
  }

  Future<void> showDialogIzin(
      String kamar,
      String nama,
      String nohp,
      String email,
      String rfid,
      String status,
      String berakhir,
      BuildContext context) async {
    kamarC.text = kamar;
    namaC.text = nama;
    nohpC.text = nohp;
    emailC.text = email;
    rfidC.text = rfid;
    selectStatus.value = status;
    endKostC.text = berakhir;
    return showDialog<void>(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tambah Izin"),
            content: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    readOnly: true,
                    autocorrect: false,
                    controller: kamarC,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: "Nomor kamar",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    readOnly: true,
                    controller: namaC,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    readOnly: true,
                    controller: nohpC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Nomor HP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    readOnly: true,
                    controller: emailC,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    readOnly: true,
                    controller: rfidC,
                    decoration: const InputDecoration(
                      labelText: "Nomor RFID",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    //padding: EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Status Kartu:"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Radio(
                          value: "yes",
                          groupValue: selectStatus.value,
                          onChanged: (value) {
                            onChangeStatus(value);
                            print(value);
                          })),
                      Text("Aktif"),
                      Obx(() => Radio(
                          value: "no",
                          groupValue: selectStatus.value,
                          onChanged: (value) {
                            onChangeStatus(value);
                            print(value);
                          })),
                      Text("Non Aktif"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    controller: endKostC,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Tanggal berakhirnya kost",
                      border: OutlineInputBorder(),
                    ),
                    // onTap: () async {
                    //   DateTime? pickedDate = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2022),
                    //       lastDate: DateTime(2101),
                    //       selectableDayPredicate: (day) {
                    //         if ((day.isBefore(
                    //             DateTime.now().subtract(Duration(days: 2))))) {
                    //           return false;
                    //         }

                    //         return true;
                    //       });
                    //   if (pickedDate != null) {
                    //     String formattedDate =
                    //         DateFormat("yyyy-MM-dd").format(pickedDate);
                    //     endKostC.text = formattedDate.toString();
                    //   }
                    // },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    addIzin(rfid);
                  },
                  child: Text("Tambah Izin"))
            ],
          );
        });
  }

  void addIzin(String rfid) async {
    final ref = FirebaseDatabase.instance.ref('izin');
    //DocumentReference rfid = firestore.collection("penghuni").doc(docID);
    if (kamarC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        nohpC.text.isNotEmpty &&
        rfidC.text.isNotEmpty &&
        kamarC.text.length == 2 &&
        selectStatus.value.isNotEmpty &&
        endKostC.text.isNotEmpty) {
      var hasil = await ref.child(rfid).set({
        "kamar": kamarC.text,
        "nama": namaC.text,
        "nohp": nohpC.text,
        "email": emailC.text,
        "rfid": rfidC.text,
        "status": selectStatus.value,
        "berakhir": endKostC.text,
        "createAt": DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.snackbar("Berhasil", "Berhasil Mengizinkan penghuni kost");
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua Field Harus di isi");
    }
  }
}
