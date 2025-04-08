import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hideui = false;

  final Connectivity _connectivity = Connectivity();

  @override
  @override
  void initState() {
    super.initState();
    _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        hideui = event == ConnectivityResult.none;
      });
    });
  }

  Stream<QuerySnapshot> getMedicineStreamForCurrentUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('medicine')
          .snapshots();
    } else {
      return Stream.empty();
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Widget getimage(String type) {
    if (type == 'Tablet') {
      return Image.asset('assets/tablet.jpg');
    } else if (type == 'Syrup') {
      return Image.asset('assets/liquid.jpg');
    } else if (type == 'Capsule') {
      return Image.asset('assets/capsule.png');
    } else {
      return Image.asset('assets/cream.webp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !hideui
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Thu'),
                    Text('Fri'),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Saturday, Sep 3',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text('Sun'),
                    Text('Mon'),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getMedicineStreamForCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Nothing Is Here, Add a Medicine',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }

                    final medicineList = snapshot.data!.docs.map((doc) {
                      return doc.data() as Map<String, dynamic>;
                    }).toList();

                    return ListView.builder(
                      itemCount: medicineList.length,
                      itemBuilder: (context, index) {
                        var medicine = medicineList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 216, 216, 214),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: hexToColor(medicine['Color']),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: getimage(medicine['type']),
                                ),
                                SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Calpol 500mg Tablet ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Dosage: ${medicine['type']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      medicine['when'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              children: [
                Icon(Icons.wifi_off),
                Text("please connect to the internet")
              ],
            ),
          );
  }
}
