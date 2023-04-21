import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/datePicker.dart';
import 'package:blood_donation/Reusable/dropDown.dart';
import 'package:blood_donation/Reusable/textFields.dart';
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
                loginButton(const PraanaHome(), context, "Register"),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}