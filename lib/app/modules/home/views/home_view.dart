import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kostparkir/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<PageIndexController>();
    final ref = FirebaseDatabase.instance
        .ref('parkir')
        .orderByChild("jammasuk")
        .limitToLast(5);

    int dataCount = 0;
    int dataCountParkir = 0;
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("parkir").once().then((event) {
      DataSnapshot snapshot = event.snapshot;
      final data = snapshot.value as Map<dynamic, dynamic>;
      if (data != null) {
        dataCount = data.length;
      }
      print('Jumlah data: $dataCount');
    });

    //final databaseReferenceP = FirebaseDatabase.instance.ref();
    databaseReference.child("penghuni").once().then((event) {
      DataSnapshot snapshot = event.snapshot;
      final data = snapshot.value as Map<dynamic, dynamic>;
      if (data != null) {
        dataCountParkir = data.length;
      }
      print('Jumlah data: $dataCountParkir');
    });

    //print(ref);
    // Future<AggregateQuerySnapshot> countRfid =
    //     FirebaseFirestore.instance.collection("penghuni").count().get();

    // Future<AggregateQuerySnapshot> countParkir =
    //     FirebaseFirestore.instance.collection("penjaga").count().get();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.toNamed(Routes.PROFIL),
        //     icon: const Icon(Icons.person),
        //   ),
        // ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snaphost) {
          if (snaphost.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snaphost.hasData) {
            Map<String, dynamic> user = snaphost.data!.data()!;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['nama']}";
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 75,
                        height: 75,
                        color: Colors.grey[200],
                        child: Image.network(
                          user["profile"] != null
                              ? user["profile"]
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ${user['nama']}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user['role'].toString().toUpperCase()}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${user['nohp']}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${user['email']}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Jumlah Penghuni"),
                          SizedBox(height: 5),
                          //Text(controller),
                          Text(
                            dataCountParkir.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Text("Jumlah motor yang parkir"), SizedBox(height: 5),
                          //Text(controller),
                          Text(
                            dataCount.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey[200],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Parkir Sekarang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.ALL_PARKIR),
                      child: Text("See more"),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: 5,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return Text("data");
                //   },
                // ),
                FirebaseAnimatedList(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Nama : ${snapshot.child('nama').value.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Tanggal : ${snapshot.child('harimasuk').value.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Kamar : ${snapshot.child('kamar').value.toString()}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Masuk : ${snapshot.child('jammasuk').value.toString()} ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: 5,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: EdgeInsets.only(bottom: 20),
                //       child: Material(
                //         color: Colors.grey[200],
                //         borderRadius: BorderRadius.circular(20),
                //         child: InkWell(
                //           onTap: () {},
                //           borderRadius: BorderRadius.circular(20),
                //           child: Container(
                //             padding: EdgeInsets.all(20),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Text(
                //                       "Nama nya",
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                     Text(
                //                       "${DateFormat.yMMMEd().format(DateTime.now())}",
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   "Kamar",
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //                 SizedBox(height: 5),
                //                 Text(
                //                   "Masuk",
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 ),

                //                 Text(
                //                     "${DateFormat.jms().format(DateTime.now())}"),

                //                 // Text(
                //                 //   "Keluar",
                //                 //   style: TextStyle(fontWeight: FontWeight.bold),
                //                 // ),
                //                 // Text("${DateFormat.jms().format(DateTime.now())}"),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            );
          } else {
            return Center(
              child: Text("tidak dapat memuat database user"),
            );
          }
        },
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
