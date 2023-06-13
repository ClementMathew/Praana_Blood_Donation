import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../HomeReusable/ProfileContainer.dart';
import '../SplashScreen.dart';

class CallProfilePage extends StatefulWidget {
  final String fieldName;
  final String fieldDob;
  final String fieldLdon;
  final String fieldId;

  const CallProfilePage(
      {Key? key,
      required this.fieldName,
      required this.fieldDob,
      required this.fieldLdon, required this.fieldId})
      : super(key: key);

  @override
  State<CallProfilePage> createState() => _CallProfilePageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference theUser = FirebaseFirestore.instance.collection('Users');
DocumentReference docRef = theUser.doc(auth.currentUser?.uid);

Map callEditData = {};

class _CallProfilePageState extends State<CallProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * .080,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: theme,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/call-edit', arguments: {
                    'last-donated': callEditData['last-donated'],
                    'id': callEditData['id']
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .06,
              ),
              Stack(children: [
                CircleAvatar(
                  radius: width * .25,
                  backgroundColor: theme,
                  child: Icon(Icons.person,
                      size: width * .25, color: Colors.white),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              callProfileShow("Name", widget.fieldName,widget.fieldId),
              divider(),
              callProfileShow("Date of Birth", widget.fieldDob,widget.fieldId),
              divider(),
              callProfileShow("Last Donated", widget.fieldLdon,widget.fieldId),
              divider(),
            ],
          ),
        ));
  }
}

Widget callProfileShow(field, fieldData,id) {

  callEditData['last-donated'] = fieldData;
  callEditData['id'] = id;

  return Padding(
    padding: EdgeInsets.fromLTRB(width * .06, 0, 0, 0),
    child: ListTile(
        title: Text(
          field,
          style: TextStyle(
              color: theme,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: .5),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(
            fieldData,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                fontFamily: "IbarraRealNova"),
          )
        )),
  );
}