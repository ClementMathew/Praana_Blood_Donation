import 'package:blood_donation/Provider/provider.dart';
import 'package:blood_donation/Welcome/forgetPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        hintText: "Enter the Number (with +91)",
                        hintStyle:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        labelText: "Phone Number",
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
                loading
                    ? CircularProgressIndicator(
                        color: theme,
                      )
                    : filledButton(
                        context,
                        otpVisibility ? "Confirm" : "Send OTP",
                        false,
                        null, () async {
                        setState(() {
                          loading = true;
                        });

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
    var tagprovider = Provider.of<TagProvider>(context, listen: false);

    QuerySnapshot snapshot = await user
        .where('phone',
            isEqualTo: int.parse(phoneController.text
                .substring(phoneController.text.length - 10)))
        .get();
    if (snapshot != null) {
      snapshot.docs.forEach((doc) async {
        await tagprovider.giveUser(doc['email'], doc['password']);
      });
    } else {
      print('Document does not exist');
    }
    await auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully by number");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        const snackBar = SnackBar(content: Text("Invalid phone number"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print("Failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        const snackBar = SnackBar(content: Text("OTP Sent"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
            loading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        const snackBar = SnackBar(content: Text("Resend OTP"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  void verifyOTP() async {
    var tagprovider = Provider.of<TagProvider>(context, listen: false);

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      auth.signInWithEmailAndPassword(
          email: tagprovider.getEmail, password: tagprovider.getPassword);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPassword(),
          ));
    }).onError((error, stackTrace) {
      const snackBar = SnackBar(content: Text("Invalid OTP"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}