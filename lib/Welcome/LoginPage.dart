import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/textFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'WelcomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
                textField(
                    false,false, "Username", "Enter email", emailTextController),
                SizedBox(height: height * .05),
                textField(true,false, "Password", "Enter the password",
                    passwordTextController),
                SizedBox(
                  height: height * .07,
                ),
                filledButton(context, "Login", false, null, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailTextController.text,
                          password: passwordTextController.text)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => const PraanaHome()),(route) => false);
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}