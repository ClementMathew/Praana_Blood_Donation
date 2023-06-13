import 'package:blood_donation/HomeReusable/ProfileContainer.dart';
import 'package:flutter/material.dart';
import '../Color/praanaColor.dart';
import '../Reusable/buttons.dart';
import '../Reusable/datePicker.dart';
import '../SplashScreen.dart';
import '../Welcome/OTPPage.dart';
import 'callProfile.dart';


class CallEditProfile extends StatefulWidget {
  const CallEditProfile({Key? key}) : super(key: key);

  @override
  State<CallEditProfile> createState() => _CallEditProfileState();
}

class _CallEditProfileState extends State<CallEditProfile> {

  @override
  void initState() {
    dateInput2.text = callEditData['last-donated'];
    // dateInput2.text = "hi";
    super.initState();
  }

  TextEditingController dateInput2 = TextEditingController();

  void updateUser(docId) {
    final data = {
      'last-donated': dateInput2.text,
    };
    user.doc(docId).update(data);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final docId = args['id'];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height * .080,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, ),
          ),
          centerTitle: true,
          backgroundColor: theme,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(height: height * .05),
                const Text('Update the last donated : ' , style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: height * .05),
                myDatePicker(context, dateInput2, "Last Donated"),
                SizedBox(
                  height: height * .07,
                ),
                loading ? CircularProgressIndicator(
                  color: theme,
                ):filledButton(context, "Confirm", false, null, () async {
                  setState(() {
                    loading = true;
                  });
                  updateUser(docId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
                SizedBox(
                  height: height * .06,
                )
              ])),
        )
    );
  }
}