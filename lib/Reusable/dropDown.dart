import 'package:blood_donation/Welcome/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Color/praanaColor.dart';
import '../Provider/provider.dart';
import '../Welcome/WelcomePage.dart';

Widget myDropDown(List<String> lists, BuildContext context) {
  bool isGroups;
  var tagProvider = Provider.of<TagProvider>(context);

  if (lists[0] == "A +ve") {
    isGroups = true;
  } else {
    isGroups = false;
  }

  return SizedBox(
    width: width * .8,
    child: InputDecorator(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: null,
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
        contentPadding: const EdgeInsets.all(3),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            hint: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(isGroups ? selectedGroup : selectedGender,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
            ),
            borderRadius: BorderRadius.circular(20),
            autofocus: true,
            items: lists
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              tagProvider.changeMenu();
              isGroups ? selectedGroup = value! : selectedGender = value!;
            }),
      ),
    ),
  );
}