import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Color/praanaColor.dart';

Map editData = {};

Widget profileShow(String detail, String content) {

  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('Users');
  DocumentReference docRef = user.doc(auth.currentUser?.uid);

  return Padding(
    padding: EdgeInsets.fromLTRB(width * .06, 0, 0, 0),
    child: ListTile(
      title: Text(detail, style: TextStyle(
          color: theme,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: .5),),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0,5,0,0),
        child:  StreamBuilder<DocumentSnapshot>(
          stream: docRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error...');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (!snapshot.hasData) {
              return const Text('No Data found');
            }
            DocumentSnapshot docSnapshot = snapshot.data!;
            String fieldData = (docSnapshot.get(content)).toString();
            editData[content] = fieldData;
            editData['id']=docSnapshot.id;

            return Text(fieldData,style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                fontFamily: "IbarraRealNova"),);
          },
        )
        )
      ),
  );
}

Widget divider() {
  return Divider(
    color: theme,
    indent: 30,
    endIndent: 30,
    thickness: 1,
  );
}