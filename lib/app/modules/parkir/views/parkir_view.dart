import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:kostparkir/app/routes/app_pages.dart';
import '../controllers/parkir_controller.dart';
import '../../../controllers/page_index_controller.dart';

class ParkirView extends GetView<ParkirController> {
  const ParkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<PageIndexController>();
    final ref = FirebaseDatabase.instance.ref('penghuni').orderByChild('kamar');
    final refId = FirebaseDatabase.instance.ref('penghuni');
    final searchC = TextEditingController();

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day + 1);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // print(now);
    // //print(isDatePassed);
    // print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Penghuni Kamar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Padding(
          //     padding: EdgeInsets.all(20),
          //     child: TextFormField(
          //       controller: controller.searchC,
          //       decoration: InputDecoration(
          //           hintText: "Cari Nomor Kamar", border: OutlineInputBorder()),
          //       onChanged: (String val) {
          //         controller.searchC;
          //       },
          //     )),
          Expanded(
            child: FirebaseAnimatedList(
                defaultChild: Text("Loading"),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final tgl = snapshot.child('berakhir').value.toString();
                  final kamar = snapshot.child('nama').value.toString();
                  DateTime dateTime = DateTime.parse(tgl);
                  bool isDatePassed = dateTime.isBefore(now);
                  print(controller.searchC.text.toString());
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
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          controller.showDialogEdit(
                                              snapshot
                                                  .child('kamar')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('nama')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('nohp')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('email')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('rfid')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('status')
                                                  .value
                                                  .toString(),
                                              snapshot
                                                  .child('berakhir')
                                                  .value
                                                  .toString(),
                                              context);
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      )),
                                  PopupMenuItem(
                                      child: ListTile(
                                    leading: Icon(Icons.add_moderator_rounded),
                                    title: Text('Izin'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      controller.showDialogIzin(
                                          snapshot
                                              .child('kamar')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('nama')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('nohp')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('email')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('rfid')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('status')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('berakhir')
                                              .value
                                              .toString(),
                                          context);
                                    },
                                  )),
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

      // StreamBuilder(
      //   stream: ref.onValue,
      //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
      //     if (!snapshot.hasData) {
      //       return Container(
      //         child: CircularProgressIndicator(),
      //         alignment: Alignment.center,
      //       );
      //     } else {
      //       Map<dynamic, dynamic> map =
      //           snapshot.data!.snapshot.value as dynamic;
      //       List<dynamic> list = [];
      //       list.clear();
      //       list = map.values.toList();
      //       return ListView.builder(
      //           padding: EdgeInsets.all(20),
      //           itemCount: snapshot.data!.snapshot.children.length,
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: EdgeInsets.only(bottom: 20),
      //               child: Material(
      //                 color: Colors.grey[200],
      //                 borderRadius: BorderRadius.circular(20),
      //                 child: InkWell(
      //                   // onTap: () => Get.toNamed(Routes.EDIT_PENGHUNI,
      //                   //     arguments: listAllDocs[index].id),
      //                   borderRadius: BorderRadius.circular(20),
      //                   child: Container(
      //                     padding: EdgeInsets.all(20),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(20),
      //                     ),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                             "Nomor Kamar    : ${(list[index]["kamar"])}"),
      //                         SizedBox(height: 5),
      //                         Text("Nama Penghuni  :${(list[index]["nama"])}"),
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Column(
      //                               children: [
      //                                 Text(
      //                                     "Nomor Hp           : ${(list[index]["nohp"])}"),
      //                                 SizedBox(height: 5),
      //                                 Text(
      //                                     "Nomor RFID       : ${(list[index]["rfid"])}"),
      //                               ],
      //                             ),
      //                             IconButton(
      //                                 onPressed: () =>
      //                                     controller.delete(list[index].id),
      //                                 icon: Icon(Icons.delete))
      //                           ],
      //                         ),
      //                         Text(
      //                             "Status                 : ${(list[index]["status"])}"),
      //                         SizedBox(height: 5),
      //                         Text(
      //                             "Email                 : ${(list[index]["email"])}"),
      //                         SizedBox(height: 5),
      //                         Text(
      //                             "Berakhir kost       : ${(list[index]["berakhir"])}"),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           });
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_RFID),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.add_circle_outline, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) => pageC.changePage(i)),
    );
  }
}
