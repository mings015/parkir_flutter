import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bukapalang_controller.dart';

class BukapalangView extends GetView<BukapalangController> {
  const BukapalangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final ref = FirebaseDatabase.instance.ref('palang');
    return Scaffold(
      appBar: AppBar(
        title: const Text('BukapalangView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Status Palang  :   ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Obx(() => Radio(
                      value: "yes",
                      groupValue: controller.selectStatus.value,
                      onChanged: (value) {
                        controller.onChangeStatus(value);
                        print(value);
                      })),
                  Text("Buka Palang"),
                  Obx(() => Radio(
                      autofocus: true,
                      value: "no",
                      groupValue: controller.selectStatus.value,
                      onChanged: (value) {
                        controller.onChangeStatus(value);
                        print(value);
                      })),
                  Text("Tutup Palang"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      controller.bukaPalang();
                    },
                    child: Text("Simpan")))
          ],
        ),
      ),
    );
  }
}
