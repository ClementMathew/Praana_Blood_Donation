import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/textFields.dart';
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
                    textField(false, "Username", "Enter email",emailTextController),
                    SizedBox(height: height * .05),
                    textField(true, "Password", "Enter the password",passwordTextController),
                    SizedBox(
                      height: height * .07,
                    ),
                    loginButton(const PraanaHome(), context, "Login"),
                    SizedBox(
                      height: height*.06,
                    )
                  ])),
            )));
  }
}