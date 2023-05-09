import 'package:blood_donation/Welcome/forgetPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../Reusable/buttons.dart';
import 'WelcomePage.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

final CollectionReference user = FirebaseFirestore.instance.collection('Users');

class _OTPPageState extends State<OTPPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool otpVisibility = false;
  String verificationID = "";

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
                  height: height * .03,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * .1, 20, width * .1, 0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter the Number",
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        labelText: "Phone number",
                        labelStyle: TextStyle(
                            fontSize: 16, color: theme, letterSpacing: .2),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: theme, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: theme, width: 2))),
                  ),
                ),
                Visibility(
                  visible: otpVisibility,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(width * .1, 20, width * .1, 0),
                    child: TextField(
                      controller: otpController,
                      style: const TextStyle(fontSize: 15),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Enter the OTP",
                          labelText: "One Time Password",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          labelStyle: TextStyle(
                              fontSize: 16, color: theme, letterSpacing: .2),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: theme, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: theme, width: 2))),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .07,
                ),
                filledButton(context, otpVisibility ? "Confirm" : "Send OTP",
                    false, null, () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        QuerySnapshot snapshot = await user
            .where('phone', isEqualTo: int.parse(phoneController.text.substring(phoneController.text.length - 10)))
            .get();
        if (snapshot != null) {
          // Access the data in the document using the snapshot's data property
          snapshot.docs.forEach((doc) async {
            await auth
                .signInWithEmailAndPassword(
                    email: doc['email'], password: doc['password'])
                .then((value) {
              print("You are logged in successfully");
            });
          });
        } else {
          print('Document does not exist');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPassword(),
          ));
    });
  }
}