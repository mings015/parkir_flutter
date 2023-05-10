import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/edit_penghuni_controller.dart';

class EditPenghuniView extends GetView<EditPenghuniController> {
  const EditPenghuniView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditPenghuniView'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        //future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.kamarC.text = data["kamar"];
            controller.namaC.text = data["namaP"];
            controller.nohpC.text = data["nohpP"];
            controller.rfidC.text = data["rfid"];
            controller.statusC.text = data["status"];

            return ListView(
              padding: const EdgeInsets.all(20),
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller.kamarC,
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
                  controller: controller.namaC,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: controller.nohpC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Nomor HP",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: controller.rfidC,
                  decoration: const InputDecoration(
                    labelText: "Nomor RFID",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: controller.statusC,
                  decoration: const InputDecoration(
                    labelText: "Status kartu",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                    autocorrect: false,
                    controller: controller.endKostC,
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
                        controller.endKostC.text = formattedDate.toString();
                      }
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.editRfid(Get.arguments);
                  },
                  child: Text("Simpan Perubahan"),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
