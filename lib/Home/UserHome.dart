import 'package:blood_donation/Home/notification.dart';
import 'package:blood_donation/Home/popUpMenu.dart';
import 'package:blood_donation/Home/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../SplashScreen.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference user =
  FirebaseFirestore.instance.collection('Users');
  late DocumentReference reference = user.doc(auth.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .080,
        title: StreamBuilder<DocumentSnapshot>(
          stream: reference.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Donate Blood Save Life",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ));
            }
            if (snapshot.hasData) {
              DocumentSnapshot docSnapshot = snapshot.data!;
              String fieldData = (docSnapshot.get('name')).toString();
              return Text(
                fieldData,
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
              Container(decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // shadow color
                    spreadRadius: 2,
                    // how spread the shadow should be
                    blurRadius: 3,
                    // how blurred the shadow should be
                    offset: const Offset(
                        0, 0), // offset of the shadow
                  ),
                ]
              ),)
            ],
          ),
        ),
      ),
    );
  }
}