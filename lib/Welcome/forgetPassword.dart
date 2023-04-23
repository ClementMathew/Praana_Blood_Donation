import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/textFields.dart';
import 'package:flutter/material.dart';
import 'WelcomePage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController rePasswordTextController = TextEditingController();
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
                        true, null, "Password", passwordTextController),
                    SizedBox(height: height * .05),
                    textField(true, null, "Retype password",
                        rePasswordTextController),
                    SizedBox(
                      height: height * .07,
                    ),
                    filledButton(context, "Change Password", false, null, () {

                    }),
                    SizedBox(
                      height: height * .06,
                    )
                  ])),
            )));
  }
}