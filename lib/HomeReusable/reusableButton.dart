import 'package:blood_donation/Color/praanaColor.dart';
import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:flutter/material.dart';


Widget reusableButton(String group,BuildContext context,final page) {
  return InkWell(
    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => page,)),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme,
            width: 3,
          )),
      height: height * .075,
      width: width * .9,
      child: Row(
        children: [
          SizedBox(
            width: width * .008,
          ),
          Container(
            width: width * .1,
            height: height * .06,
            decoration: BoxDecoration(
                color: theme,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15))),
          ),
          const Spacer(),
          Text(
            group,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "IbarraRealNova",
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: .5),
          ),
          const Spacer(),
          Container(
            width: width * .1,
            height: height * .06,
            decoration: BoxDecoration(
                color: theme,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15))),
          ),
          SizedBox(
            width: width * .008,
          )
        ],
      ),
    ),
  );
}