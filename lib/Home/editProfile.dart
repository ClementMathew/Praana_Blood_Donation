import 'package:blood_donation/HomeReusable/ProfileContainer.dart';
import 'package:blood_donation/Welcome/RegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Color/praanaColor.dart';
import '../Reusable/buttons.dart';
import '../Reusable/datePicker.dart';
import '../Reusable/dropDown.dart';
import '../Reusable/textFields.dart';
import '../SplashScreen.dart';
import '../Welcome/OTPPage.dart';
import '../Welcome/WelcomePage.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  void initState() {
    selectedGroup = editData['blood-grp'];
    selectedGender = editData['gender'];
    dateInput.text = editData['dob'];
    dateInput2.text = editData['last-donated'];
    super.initState();
  }

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  void updateUser(docId) {
    final data = {
      'name': nameTextController.text,
      'phone': phoneTextController.text,
      'weight': weightTextController.text,
      'dob': dateInput.text,
      'last-donated': dateInput2.text,
      'blood-grp': selectedGroup,
      'gender': selectedGender
    };
    user.doc(docId).update(data);
  }

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

  List<String> gender = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map;
    nameTextController.text = args['name'];
    phoneTextController.text = args['phone'];
    weightTextController.text = args['weight'];
    final docId = args['id'];

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
                MyDropDown(myList: groups,isEdit: true,),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput2, "Last Donated"),
                SizedBox(height: height * .05),
                textField(false,true, null, "Weight", weightTextController),
                SizedBox(height: height * .05),
                MyDropDown(myList:gender,isEdit: true,),
                SizedBox(
                  height: height * .07,
                ),
                loading ? CircularProgressIndicator(
                  color: theme,
                ):filledButton(context, "Confirm", false, null, () async {
                  setState(() {
                    loading = true;
                  });
                  updateUser(docId);
                  Navigator.pop(context);
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
        )
    );
  }
}