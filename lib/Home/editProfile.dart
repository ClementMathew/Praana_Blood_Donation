import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Color/praanaColor.dart';
import '../Reusable/buttons.dart';
import '../Reusable/datePicker.dart';
import '../Reusable/dropDown.dart';
import '../Reusable/textFields.dart';
import '../Welcome/WelcomePage.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  // void updateUser(docId) {
  //   final data = {
  //     'name': testName.text,
  //     'phone': testPhone.text,
  //     'letter': selectedLetter
  //   };
  //   test.doc(docId).update(data);
  // }

  bool loading = false;

  List<String> groups = [
    'A Positive',
    'A Negative',
    'B Positive',
    'B Negative',
    'O Positive',
    'O Negative',
    'AB Positive',
    'AB Negative',
  ];

  String? selectedGender_1;
  String? selectedGroup_1;

  List<String> gender = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: height * .080,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, ),
        ),
        centerTitle: true,
        backgroundColor: theme,
      ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
                SizedBox(
                  height: height * .05,
                ),
                textField(false,false, null, "Name", nameTextController),
                SizedBox(height: height * .05),
                textField(false, true,null, "Phone Number", phoneTextController),
                SizedBox(height: height * .025),
                myDatePicker(context, dateInput, "Date of Birth"),
                SizedBox(height: height * .05),
                myDropDown(groups, context),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput2, "Last Donated"),
                SizedBox(height: height * .05),
                textField(false,true, null, "Weight", weightTextController),
                SizedBox(height: height * .05),
                myDropDown(gender, context),
                SizedBox(
                  height: height * .07,
                ),
                loading ? CircularProgressIndicator(
                  color: theme,
                ):filledButton(context, "Confirm", false, null, () async {
                  setState(() {
                    loading = true;
                  });

                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
        )
    );
  }
}