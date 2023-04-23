import 'package:blood_donation/Welcome/forgetPassword.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../Reusable/buttons.dart';
import 'WelcomePage.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController otpTextController = TextEditingController();

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

                SizedBox(
                  height: height * .07,
                ),
                filledButton(context, "Send OTP", false, null, () {}),
                SizedBox(
                  height: height * .04,
                ),
                filledButton(context, "Confirm", false, null, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }
}