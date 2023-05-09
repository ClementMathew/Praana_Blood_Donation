import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Color/praanaColor.dart';
import '../Provider/provider.dart';
import '../Welcome/WelcomePage.dart';

Widget myDatePicker(BuildContext context, final controller, String hint) {
  var tagProvider = Provider.of<TagProvider>(context);

  return SizedBox(
    width: width * .8,
    child: TextField(
      readOnly: true,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () async {
                tagProvider.changeDate(context, controller);
              }),
          suffixIconColor: theme,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 17, color: theme, letterSpacing: .2),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: theme, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: theme, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: theme, width: 2)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: theme, width: 2)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black,fontSize: 15)),
      controller: controller,
    ),
  );
}