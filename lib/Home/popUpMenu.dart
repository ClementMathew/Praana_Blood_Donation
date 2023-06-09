import 'package:blood_donation/Home/AboutPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Welcome/WelcomePage.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        value();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7)),

      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: (){
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              const snackBar = SnackBar(content: Text("Signed Out"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomePage()),(route) => false);
            });
          },
          child: const Row(
            children: [Icon(Icons.logout,color: Colors.black),
              SizedBox(width: 15,),
              Text('Logout',style: TextStyle(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
         PopupMenuItem(
          value: (){
            _launchURL();
          },
          child: const Row(
            children: [Icon(Icons.cached,color: Colors.black,),
              SizedBox(width: 15,),
              Text('Check for Updates',style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
         PopupMenuItem(
          value: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage(),));
          },
          child: const Row(
            children: [Icon(Icons.info_outline,color: Colors.black,),
              SizedBox(width: 15,),
              Text('About',style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

_launchURL() async {
  const url =
      'https://drive.google.com/drive/folders/1hFXYJVqw4PHz1njvuRjusA3BEJfLVBV1?usp=sharing';

  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri,)) {
    await launchUrl(uri,mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}