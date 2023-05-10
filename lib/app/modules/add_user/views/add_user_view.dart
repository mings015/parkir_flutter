import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Penjaga Kost'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextField(
            autocorrect: false,
            controller: controller.nohpC,
            decoration: const InputDecoration(
              labelText: "Nomor Hp",
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
            controller: controller.emailC,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) await controller.addUser();
                },
                child:
                    Text(controller.isLoading.isFalse ? "Tambah" : "Loading.."),
              )),
        ],
      ),
    );
  }
}
