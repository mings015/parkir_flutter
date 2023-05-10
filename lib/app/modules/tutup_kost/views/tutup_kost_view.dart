import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tutup_kost_controller.dart';

class TutupKostView extends GetView<TutupKostController> {
  const TutupKostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TutupKostView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TutupKostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
