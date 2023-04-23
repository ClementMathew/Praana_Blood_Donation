import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/datePicker.dart';
import 'package:blood_donation/Reusable/dropDown.dart';
import 'package:blood_donation/Reusable/textFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'WelcomePage.dart';

String selectedGroup = "Blood Group";
String selectedGender = "Gender";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> groups = [
    'A +ve',
    'A -ve',
    'B +ve',
    'B -ve',
    'O +ve',
    'O -ve',
    'AB +ve',
    'AB -ve',
  ];

  List<String> gender = ['Male', 'Female'];

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController rePasswordTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  final CollectionReference user =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(String name, String phone, String dob,
      String bloodGrp, String lastDon, String weight, String gender) async {
    return await user.doc(_auth.currentUser?.uid).set({
      'name': name,
      'phone': phone,
      'dob': dob,
      'blood-grp': bloodGrp,
      'last-donated': lastDon,
      'weight': weight,
      'gender': gender,
    });
  }

  void addUser() {
    updateUserData(
        nameTextController.text,
        phoneTextController.text,
        dateInput.text,
        selectedGroup,
        dateInput2.text,
        weightTextController.text,
        selectedGender);
  }

  @override
  void initState() {
    selectedGroup = "Blood Group";
    selectedGender = "Gender";
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: background,
            body: SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                backButton(context),
                SizedBox(
                    height: height * .43,
                    child: Image.asset("assets/images/Praana.png")),
                SizedBox(
                  height: height * .05,
                ),
                textField(false, null, "Name", nameTextController),
                SizedBox(height: height * .05),
                textField(false, null, "Phone Number", phoneTextController),
                SizedBox(height: height * .025),
                textField(false, null, "Email", emailTextController),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput, "Date of Birth"),
                SizedBox(height: height * .05),
                myDropDown(groups, context),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput2, "Last Donated"),
                SizedBox(height: height * .05),
                textField(false, null, "Weight", weightTextController),
                SizedBox(height: height * .05),
                myDropDown(gender, context),
                SizedBox(height: height * .05),
                textField(true, null, "Password", passwordTextController),
                SizedBox(height: height * .05),
                textField(
                    true, null, "Retype Password", rePasswordTextController),
                SizedBox(
                  height: height * .07,
                ),
                filledButton(context, "Register", false, null, () {
                  if (passwordTextController.text ==
                      rePasswordTextController.text) {
                    _auth.createUserWithEmailAndPassword(
                      email: emailTextController.text,
                      password: passwordTextController.text,
                    )
                        .then((value) {
                      addUser();
                      print("Created New Account");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PraanaHome()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  } else {
                    print("not match");
                  }
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}