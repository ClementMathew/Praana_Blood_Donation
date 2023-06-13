import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/textFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Home/UserHome.dart';
import '../SplashScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  bool loading = false;

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
                textField(false, false, "Username", "Enter college email",
                    emailTextController),
                SizedBox(height: height * .05),
                textField(true, false, "Password", "Enter the password",
                    passwordTextController),
                SizedBox(
                  height: height * .07,
                ),
                loading
                    ? CircularProgressIndicator(
                        color: theme,
                      )
                    : filledButton(context, "Login", false, null, () async {
                        setState(() {
                          loading = true;
                        });
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailTextController.text.trim(),
                                password: passwordTextController.text.trim())
                            .then((value) {
                          if (emailTextController.text == 'nss@gecwyd.ac.in') {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PraanaHome()),
                                (route) => false);
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserHome()),
                                (route) => false);
                          }
                        }).onError((error, stackTrace) {
                          const snackBar =
                              SnackBar(content: Text("Invalid Credentials"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            loading = false;
                          });
                        });
                      }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}