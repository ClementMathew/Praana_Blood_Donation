
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Color/praanaColor.dart';
import '../SplashScreen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference user =
  FirebaseFirestore.instance.collection('Users');
  late DocumentReference reference = user.doc(auth.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * .080,
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: theme,
        ),
        body: SingleChildScrollView(child:StreamBuilder<DocumentSnapshot>(
          stream: reference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.hasData) {
              DocumentSnapshot docSnapshot = snapshot.data!;
              int fieldData = (DateTime.now().difference(DateTime.parse(docSnapshot.get('last-donated')))).inDays.toInt();
              if(fieldData >= 90){
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(18),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // shadow color
                          spreadRadius: 2, // how spread the shadow should be
                          blurRadius: 3, // how blurred the shadow should be
                          offset: const Offset(0, 0), // offset of the shadow
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        docSnapshot.get("name"),
                        style: TextStyle(
                            color: theme,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(DateFormat('yyyy-MM-dd , kk:mm a').format(DateTime.now()).toString(),
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Now you can donate blood .. !",
                        style: TextStyle(fontFamily: "IbarraRealNova", fontSize: 19),
                      ),
                    ],
                  ),
                );
              }
              else{
                return const Center(child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("------    No notifications    ------",style: TextStyle(fontFamily: "IbarraRealNova", fontSize: 20)),
                ));
              }
            }
            return Container();
          },
        )));
  }
}