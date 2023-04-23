import 'package:flutter/material.dart';
import '../Color/praanaColor.dart';
import '../Welcome/WelcomePage.dart';

Widget filledButton(BuildContext context, String name, bool isLogin, final page,
    Function onTap) {
  return ElevatedButton(
    onPressed: () {
      isLogin
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => page))
          : onTap();
    },
    style: ElevatedButton.styleFrom(
        backgroundColor: theme,
        fixedSize: Size(width * .74, height * .065),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
    child: Text(name,
        style: const TextStyle(
            fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 18)),
  );
}

Widget outlineButton(BuildContext context, String name, bool isLogin, final page,
    Function onTap) {
  return OutlinedButton(
    onPressed: () {
      isLogin
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => page))
          : onTap();
    },
    style: OutlinedButton.styleFrom(
        side: BorderSide(width: 2.0, color: theme),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        fixedSize: Size(width * .74, height * .065)),
    child: Text(name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: .5,
          fontSize: 18,
          color: theme,
        )),
  );
}

Widget backButton(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        iconSize: 30,
        icon: const Icon(Icons.arrow_back),
        color: theme,
      ),
    ),
  );
}