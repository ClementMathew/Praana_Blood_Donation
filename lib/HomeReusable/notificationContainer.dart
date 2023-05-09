import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';

Widget notify() {
  return Container(
    margin: const EdgeInsets.fromLTRB(15,15, 15, 0),
    padding: const EdgeInsets.all(10),
    height: height * .2,
    width: double.infinity,
    decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey, offset: Offset(5, 5), blurRadius: 10)
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Clement Mathew",
          style: TextStyle(
              color: theme,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: .5),
        ),
        const Text(
          "22-05-2023",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        const Text("hi"),
      ],
    ),
  );
}