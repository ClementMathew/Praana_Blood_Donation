import 'package:blood_donation/Welcome/WelcomePage.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';

Widget profileShow(String detail, String content) {
  return Padding(
    padding: EdgeInsets.fromLTRB(width * .06, 0, 0, 0),
    child: ListTile(
      title: Text(detail, style: TextStyle(
          color: theme,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: .5),),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0,5,0,0),
        child: Text(content,style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            fontFamily: "IbarraRealNova")),
      ),
    ),
  );
}

Widget divider() {
  return Divider(
    color: theme,
    indent: 30,
    endIndent: 30,
    thickness: 1,
  );
}