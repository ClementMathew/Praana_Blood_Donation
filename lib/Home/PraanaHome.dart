import 'package:blood_donation/Home/notification.dart';
import 'package:blood_donation/Home/popUpMenu.dart';
import 'package:blood_donation/Home/profile.dart';
import 'package:blood_donation/Home/studentList.dart';
import 'package:blood_donation/HomeReusable/reusableButton.dart';
import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';

class PraanaHome extends StatefulWidget {
  const PraanaHome({Key? key}) : super(key: key);

  @override
  State<PraanaHome> createState() => _PraanaHomeState();
}

class _PraanaHomeState extends State<PraanaHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference user =
      FirebaseFirestore.instance.collection('Users');
  late DocumentReference reference = user.doc(auth.currentUser?.uid);
  late Future<DocumentSnapshot> futureData = reference.get();
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .080,
        title: FutureBuilder<DocumentSnapshot>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("Donate Blood Save Life ${snapshot.error}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ));
            }
            if (snapshot.hasData) {
              DocumentSnapshot documentSnapshot = snapshot.data;
              Map data = (documentSnapshot.data()) as Map;
              return Text(
                "${data['name']}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    ),
              );
            }
            return const Text("Loading...");
          },
        ),
        backgroundColor: theme,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
          icon: const Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ));
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 24.0,
              )),
          const SizedBox(
            width: 1,
          ),
          const PopUpMenu(),
          // IconButton(
          //   onPressed: () {
          //
          //   },
          //   icon: const Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //     size: 26,
          //   ),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * .025,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(100, 233, 233, 233)),
                height: height * .06,
                width: width * .9,
                child: Center(
                  child: Text(
                    "Blood Groups",
                    style: TextStyle(
                        color: theme,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5),
                  ),
                ),
              ),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "A +ve",
                  context,
                  const StudentList(
                    name: 'A Positive',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "A -ve",
                  context,
                  const StudentList(
                    name: 'A Negative',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "B +ve",
                  context,
                  const StudentList(
                    name: 'B Positive',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "B -ve",
                  context,
                  const StudentList(
                    name: 'B Negative',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "AB +ve",
                  context,
                  const StudentList(
                    name: 'AB Positive',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "AB -ve",
                  context,
                  const StudentList(
                    name: 'AB Negative',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "O +ve",
                  context,
                  const StudentList(
                    name: 'O Positive',
                  )),
              SizedBox(
                height: height * .020,
              ),
              reusableButton(
                  "O -ve",
                  context,
                  const StudentList(
                    name: 'O Negative',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}