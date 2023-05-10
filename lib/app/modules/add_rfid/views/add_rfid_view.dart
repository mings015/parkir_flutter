import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../controllers/add_rfid_controller.dart';

class AddRfidView extends GetView<AddRfidController> {
  const AddRfidView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String selectStatus = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Penghuni Kost'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // DropdownSearch<String>(
          //   popupProps: PopupProps.dialog(
          //     showSelectedItems: true,
          //   ),
          //   items: [
          //     "1",
          //     "2",
          //     "3",
          //     "4",
          //     "5",
          //     "6",
          //     "7",
          //     "8",
          //     "9",
          //     "10",
          //     "11",
          //     "12",
          //     "13",
          //     "14",
          //     "15",
          //     "16",
          //     "17",
          //     "18",
          //     "19",
          //     "20"
          //   ],
          //   onChanged: (value) => controller.kamarC,
          //   selectedItem: "Nomor kamar",
          // ),
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
                hintText: "11:11:11:11"),
          ),
          const SizedBox(height: 10),
          // DropdownSearch<String>(
          //   popupProps: PopupProps.menu(
          //     showSelectedItems: true,
          //   ),
          //   items: ["True", "False"],
          //   onChanged: (value) => controller.statusC,
          //   selectedItem: "Status Kartu",
          // ),
          // TextField(
          //   autocorrect: false,
          //   controller: controller.statusC,
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     labelText: "Status kartu",
          //     border: OutlineInputBorder(), // radio button :(
          //   ),
          // ),

          Container(
            padding: EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Status Kartu  :   "),
                Obx(() => Radio(
                    value: "yes",
                    groupValue: controller.selectStatus.value,
                    onChanged: (value) {
                      controller.onChangeStatus(value);
                      print(value);
                    })),
                Text("Aktif"),
                Obx(() => Radio(
                    value: "no",
                    groupValue: controller.selectStatus.value,
                    onChanged: (value) {
                      controller.onChangeStatus(value);
                      print(value);
                    })),
                Text("Non Aktif"),
              ],
            ),
          ),

          const SizedBox(height: 10),
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
              controller.addRfid();
            },
            child: Text("Simpan"),
          ),
          // Obx(() => ElevatedButton(
          //       onPressed: () async {
          //         if (controller.isLoading.isFalse) await controller.addUser();
          //       },
          //       child:
          //           Text(controller.isLoading.isFalse ? "Tambah" : "Loading.."),
          //     )),
        ],
      ),
    );
  }
}
