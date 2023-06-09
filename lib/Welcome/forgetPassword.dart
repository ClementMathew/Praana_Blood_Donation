import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Provider/provider.dart';
import 'package:blood_donation/Reusable/buttons.dart';
import 'package:blood_donation/Reusable/textFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../SplashScreen.dart';
import 'WelcomePage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController rePasswordTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  bool loading = false;

  final CollectionReference user =
  FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> updateUserData(String password) async {
    return await user.doc(auth.currentUser?.uid).update({
      'password':password
    });
  }

  void updateUser() {
    updateUserData(
        passwordTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    var tagprovdier = Provider.of<TagProvider>(context);

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
                textField(true, false, null, "New Password",
                    passwordTextController),
                SizedBox(height: height * .05),
                textField(true, false, null, "Retype password",
                    rePasswordTextController),
                SizedBox(
                  height: height * .07,
                ),
                loading?CircularProgressIndicator(
                  color: theme,
                ):filledButton(context, "Change Password", false, null, () {
                  setState(() {
                    loading = true;
                  });
                  if (passwordTextController.text ==
                      rePasswordTextController.text) {
                    changePassword(tagprovdier.getEmail,
                        tagprovdier.getPassword, passwordTextController.text);
                  }
                  else{
                    const snackBar = SnackBar(content: Text("Passwords doesn't match"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      loading = false;
                    });
                  }
                },),
                SizedBox(
                  height: height * .06,
                )
              ])),
            )));
  }

  changePassword(String email, String oldpassword, String newpassword) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
      const snackBar = SnackBar(content: Text("Password changed successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      updateUser();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WelcomePage()),(route) => false);
    }).catchError((error) {
      const snackBar = SnackBar(content: Text("You are not registered"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
}