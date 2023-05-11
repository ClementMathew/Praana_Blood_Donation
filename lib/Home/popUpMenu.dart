import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomePage()));
            });
          },
          child: Row(
            children: const [Icon(Icons.logout,color: Colors.black),
              SizedBox(width: 15,),
              Text('Logout',style: TextStyle(fontWeight: FontWeight.w500),),
            ],
          ),
        ),
         PopupMenuItem(
          value: (){},
          child: Row(
            children: const [Icon(Icons.cached,color: Colors.black,),
              SizedBox(width: 15,),
              Text('Check for Updates',style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
         PopupMenuItem(
          value: (){},
          child: Row(
            children: const [Icon(Icons.info_outline,color: Colors.black,),
              SizedBox(width: 15,),
              Text('About',style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}