import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Welcome/LoginPage.dart';
import 'package:blood_donation/Welcome/OTPPage.dart';
import 'package:blood_donation/Welcome/RegisterPage.dart';
import 'package:flutter/material.dart';

var size, height, width;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * .10,
                ),
                SizedBox(
                    height: height * .43,
                    child: Image.asset("assets/images/Praana.png")),
                SizedBox(
                  height: height * .1,
                ),
                filledButton(context, "Login",true,const LoginPage(),(){}),
                SizedBox(
                  height: height * .045,
                ),
                outlineButton(context, "Sign Up",true,const RegisterPage(),(){}),
                SizedBox(
                  height: height * .05,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPPage(),));
                  },
                  style: TextButton.styleFrom(fixedSize: const Size(188, 13)),
                  child: const Text('Forgot Password ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: .2,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}