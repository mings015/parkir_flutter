import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/izin_controller.dart';

class IzinView extends GetView<IzinController> {
  const IzinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('izin').orderByChild('kamar');
    final refId = FirebaseDatabase.instance.ref('izin');

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day + 1);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IzinView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                defaultChild: Text("Loading"),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final tgl = snapshot.child('berakhir').value.toString();
                  final kamar = snapshot.child('nama').value.toString();
                  DateTime dateTime = DateTime.parse(tgl);
                  bool isDatePassed = dateTime.isBefore(now);

                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      //color: Colors.amber,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                  "Nomor Kamar    : ${snapshot.child('kamar').value.toString()}"),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      onTap: () {
                                        refId
                                            .child(snapshot
                                                .child('rfid')
                                                .value
                                                .toString())
                                            .remove();
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text('Delete'),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Nama      : ${snapshot.child('nama').value.toString()}"),
                                  SizedBox(height: 5),
                                  Text(
                                      "Nomor Hp : ${snapshot.child('nohp').value.toString()}"),
                                  SizedBox(height: 5),
                                  Text(
                                      "Email      : ${snapshot.child('email').value.toString()}"),
                                  SizedBox(height: 5),
                                  Text(
                                      "Nomor RFID : ${snapshot.child('rfid').value.toString()}"),
                                  SizedBox(height: 5),
                                  Text(
                                      "Status     : ${snapshot.child('status').value.toString()}"),
                                  SizedBox(height: 5),
                                  Text(
                                    "Berakhir : ${snapshot.child('berakhir').value.toString()}",
                                    style: TextStyle(
                                      color: isDatePassed
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
