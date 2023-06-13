import 'package:blood_donation/HomeReusable/notificationContainer.dart';
import 'package:flutter/material.dart';

import '../Color/praanaColor.dart';
import '../SplashScreen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * .080,
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: theme,
        ),
        body: SingleChildScrollView(child: notify()));
  }
}