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

  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController rePasswordTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  bool loading = false;

  final CollectionReference user =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(String name, int phone,String email, String dob,
      String bloodGrp, String lastDon, String weight, String gender,String password) async {
    return await user.doc(_auth.currentUser?.uid).set({
      'name': name,
      'phone': phone,
      'email':email,
      'dob': dob,
      'blood-grp': bloodGrp,
      'last-donated': lastDon,
      'weight': weight,
      'gender': gender,
      'password':password
    });
  }

  void addUser() {
    updateUserData(
        nameTextController.text,
        int.parse(phoneTextController.text),
        emailTextController.text,
        dateInput.text,
        selectedGroup,
        dateInput2.text,
        weightTextController.text,
        selectedGender,
        passwordTextController.text);
  }

  @override
  void initState() {
    selectedGroup = "Blood Group";
    selectedGender = "Gender";
    dateInput.text = "";
    dateInput2.text = "";//set the initial value of text field
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
                textField(false,false, null, "Name", nameTextController),
                SizedBox(height: height * .05),
                textField(false, true,null, "Phone Number", phoneTextController),
                SizedBox(height: height * .025),
                textField(false,false, null, "Email ( College mail )", emailTextController),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput, "Date of Birth"),
                SizedBox(height: height * .05),
                myDropDown(groups, context),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput2, "Last Donated"),
                SizedBox(height: height * .05),
                textField(false,true, null, "Weight", weightTextController),
                SizedBox(height: height * .05),
                myDropDown(gender, context),
                SizedBox(height: height * .05),
                textField(true, false,null, "New Password", passwordTextController),
                SizedBox(height: height * .05),
                textField(
                    true,false,  null, "Retype Password", rePasswordTextController),
                SizedBox(
                  height: height * .07,
                ),
                loading ? CircularProgressIndicator(
                  color: theme,
                ):filledButton(context, "Register", false, null, () async {
                  setState(() {
                    loading = true;
                  });
                  if (passwordTextController.text ==
                      rePasswordTextController.text && emailTextController.text.contains("@gecwyd.ac.in")) {
                    await _auth.createUserWithEmailAndPassword(
                      email: emailTextController.text,
                      password: passwordTextController.text,
                    )
                        .then((value) {
                      addUser();
                      print("Created New Account");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PraanaHome()),(route) => false);
                    }).onError((error, stackTrace) {
                      var snackBar = const SnackBar(content: Text("Password should be at least 6 characters or Email already taken"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        loading = false;
                      });
                    });
                  } else {
                    const snackBar = SnackBar(content: Text("Invalid email or Passwords doesn't match"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      loading = false;
                    });
                  }
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}