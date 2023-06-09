import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Color/praanaColor.dart';
import '../SplashScreen.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: height * .080,
        title: const Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Praana',
              style: TextStyle(
                  color: Color.fromARGB(255, 43, 45, 66),
                  fontFamily: "Kanit",
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 20),
            child: Text('Created in 2023',
              style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              'This app is an initiative taken by the 2022-23 NSS Execom to find donors easily.',
              style: TextStyle(
                color: Color.fromARGB(255, 43, 45, 66),
                fontFamily: "Kanit",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Divider(
              height: 1,
              color: theme,
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Color.fromARGB(255, 43, 45, 66),
                  fontFamily: "Kanit",
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 20),
            child: Text('Last updated June 10,2023',
              style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              'This app does not process any sensitive personal information or recieve any infomation from third parties.',
              style: TextStyle(
                color: Color.fromARGB(255, 43, 45, 66),
                fontFamily: "Kanit",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Divider(
              height: 1,
              color: theme,
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                  color: Color.fromARGB(255, 43, 45, 66),
                  fontFamily: "Kanit",
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Developed and maintained by Clement Mathew.',
              style: TextStyle(
                color: Color.fromARGB(255, 43, 45, 66),
                fontFamily: "Kanit",
                fontSize: 15,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Text(
              'If you have questions or comments about this, you may email me clicking the email below.',
              style: TextStyle(
                color: Color.fromARGB(255, 43, 45, 66),
                fontFamily: "Kanit",
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: TextButton(
                onPressed: () {
                  launchEmail();
                },
                child: const Text('clementmathew652@gmail.com')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Divider(
              height: 1,
              color: theme,
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
  Future launchEmail({
    String toEmail = "clementmathew652@gmail.com",
  }) async {
    // ignore: unused_local_variable
    Uri mail = Uri.parse("mailto:$toEmail");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}