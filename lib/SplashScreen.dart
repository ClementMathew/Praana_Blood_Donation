
import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Home/PraanaHome.dart';
import 'package:blood_donation/Home/UserHome.dart';
import 'package:blood_donation/Welcome/LoginPage.dart';
import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var size,height,width;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      //exit fullscreen
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //     systemNavigationBarColor: Colors.white,
      //     statusBarColor: Colors
      //         .white)); //need it to be transparent in both light&dark themes
      if (FirebaseAuth.instance.currentUser != null) {
        if(FirebaseAuth.instance.currentUser?.email == "nss@gecwyd.ac.in"){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const PraanaHome()));
        }else{
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const UserHome()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const WelcomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * .10,
              ),
              SizedBox(
                  height: height * .55,
                  child: Image.asset("assets/images/Praana.png")),
              SizedBox(height: height*.1,),
              Center(
                child: Container(
                  color: Colors.transparent,
                  height: height*.045,
                  width: height*.045,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}