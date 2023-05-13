import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';

Widget notify() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    padding: const EdgeInsets.all(18),
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // shadow color
            spreadRadius: 2, // how spread the shadow should be
            blurRadius: 3, // how blurred the shadow should be
            offset: const Offset(0, 0), // offset of the shadow
          ),
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
        const SizedBox(
          height: 4,
        ),
        const Text(
          "22-05-2023 , 12:30 pm",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Now you can donate blood .. !",
          style: TextStyle(fontFamily: "IbarraRealNova", fontSize: 19),
        ),
      ],
    ),
  );
}