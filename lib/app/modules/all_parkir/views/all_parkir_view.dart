import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/all_parkir_controller.dart';

class AllParkirView extends GetView<AllParkirController> {
  const AllParkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('parkir').orderByChild("kamar");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Parkir'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FirebaseAnimatedList(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Material(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nama : ${snapshot.child('nama').value.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Tanggal : ${snapshot.child('harimasuk').value.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Kamar : ${snapshot.child('kamar').value.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Masuk : ${snapshot.child('jammasuk').value.toString()} ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          // Text(
                          //     "${DateFormat.jms().format(DateTime.now())}"),

                          // Text(
                          //   "Keluar",
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          // Text("${DateFormat.jms().format(DateTime.now())}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
