import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../HomeReusable/ProfileContainer.dart';
import '../SplashScreen.dart';
import '../Welcome/WelcomePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * .080,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: theme,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit', arguments: {
                    'name': editData['name'],
                    'phone' : editData['phone'],
                    'dob' : editData['dob'],
                    'last-donated':editData['last-donated'],
                    'weight': editData['weight'],
                    'id':editData['id']
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .06,
              ),
              CircleAvatar(
                radius: width * .25,
                backgroundColor: theme,
                child:
                Icon(Icons.add_a_photo, size: width * .15, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              profileShow("Name", "name"),
              divider(),
              profileShow("Phone Number", "phone"),
              divider(),
              profileShow("Email", "email"),
              divider(),
              profileShow("Date of Birth", "dob"),
              divider(),
              profileShow("Blood Group", "blood-grp"),
              divider(),
              profileShow("Last Donated", "last-donated"),
              divider(),
              profileShow("Weight", "weight"),
              divider(),
              profileShow("Gender", "gender"),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}