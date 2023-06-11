import 'package:blood_donation/Home/notification.dart';
import 'package:blood_donation/Home/popUpMenu.dart';
import 'package:blood_donation/Home/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Color/praanaColor.dart';
import '../SplashScreen.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int activeIndex = 0;

  final images = [
    'assets/images/slider1.webp',
    'assets/images/slider2.webp',
    'assets/images/slider3.jpg'
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference user =
      FirebaseFirestore.instance.collection('Users');
  late DocumentReference reference = user.doc(auth.currentUser?.uid);

  late double per =0 ;

  findPer()async {
    DocumentSnapshot snapshot = await reference
        .get();
    if (snapshot.exists) {
      int fieldData = (DateTime.now().difference(
          DateTime.parse(snapshot.get('last-donated')))).inDays.toInt();
      setState(() {
        per = ((fieldData / 90).toDouble());
      });
    } else {
      print('Document does not exist');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findPer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .080,
        title: StreamBuilder<DocumentSnapshot>(
          stream: reference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Donate Blood Save Life",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ));
            }
            if (snapshot.hasData) {
              DocumentSnapshot docSnapshot = snapshot.data!;
              String fieldData = (docSnapshot.get('name')).toString();
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ));
                },
                child: Text(
                  fieldData,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return const Text("Loading...");
          },
        ),
        backgroundColor: theme,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
          icon: const Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ));
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 24.0,
              )),
          const SizedBox(
            width: 1,
          ),
          const PopUpMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  height: height * .07,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // shadow color
                          spreadRadius: 1,
                          // how spread the shadow should be
                          blurRadius: 2,
                          // how blurred the shadow should be
                          offset: const Offset(0, 0), // offset of the shadow
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      'Hello 👋, Life Saver',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    final image = images[index];
                    return buildImage(image, index);
                  },
                  options: CarouselOptions(
                      height: height * .25,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index)),
                ),
              ),
              SizedBox(
                height: height*.02,
              ),
              buildIndicator(),
              SizedBox(
                height: height*.025,
              ),
              Container(
                height: height * .43,
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // shadow color
                        spreadRadius: 1,
                        // how spread the shadow should be
                        blurRadius: 2,
                        // how blurred the shadow should be
                        offset: const Offset(0, 0), // offset of the shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: themestud, width: 4)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                      child:StreamBuilder<DocumentSnapshot>(
                        stream: reference.snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Have you donated blood",
                                style: GoogleFonts.ptSans(
                                        fontSize: 22, fontWeight: FontWeight.bold),
                                  );
                          }
                          if (snapshot.hasData) {
                            DocumentSnapshot docSnapshot = snapshot.data!;
                            String fieldData = (DateTime.now().difference(DateTime.parse(docSnapshot.get('last-donated')))).inDays.toString();
                            return Text(
                              'You donated $fieldData days ago',
                              style: GoogleFonts.ptSans(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            );
                          }
                          return Text("Loading...",style: GoogleFonts.ptSans(
                              fontSize: 22, fontWeight: FontWeight.bold),);
                        },
                      ),
                    ),
                    SizedBox(
                        height: height * .03,
                        width: width * .85,
                        child: Image.asset("assets/images/lineblood.png")),
                    SizedBox(
                      height: height*.026,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: width*.09,),
                        CircularPercentIndicator(
                          radius: 55,
                          lineWidth: 10,
                          percent: per,
                          animation: true,
                          backgroundColor: Colors.white,
                          circularStrokeCap: CircularStrokeCap.round,
                          animationDuration: 3000,
                          progressColor: theme,
                          center: StreamBuilder<DocumentSnapshot>(
                            stream: reference.snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("0%",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold, fontSize: 30),
                                );
                              }
                              if (snapshot.hasData) {
                                DocumentSnapshot docSnapshot = snapshot.data!;
                                int fieldData = (DateTime.now().difference(DateTime.parse(docSnapshot.get('last-donated')))).inDays.toInt();
                                return Text(
                                  '${((fieldData/90)*100).toStringAsPrecision(2)}%',
                                  style:  GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold, fontSize: 30),
                                );
                              }
                              return Text("0%",style:GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 30),);
                            },
                          ),
                        ),
                        SizedBox(width:width*.08),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: height*.016,),
                            Text(
                              "Blood Group : ",
                              style: GoogleFonts.ptSans(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: height*.004,),
                            Row(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: reference.snapshots(),
                                  builder:
                                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Nil",
                                        style: GoogleFonts.poppins(
                                                fontSize: 45, fontWeight: FontWeight.bold),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      DocumentSnapshot docSnapshot = snapshot.data!;
                                      List fieldData = docSnapshot.get('blood-grp').toString().split(' ');
                                      return Text(
                                        fieldData[0],
                                        style: GoogleFonts.poppins(
                                                fontSize: 45, fontWeight: FontWeight.bold),
                                      );
                                    }
                                    return const Text("Loading...");
                                  },
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: reference.snapshots(),
                                  builder:
                                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      DocumentSnapshot docSnapshot = snapshot.data!;
                                      List fieldData = docSnapshot.get('blood-grp').toString().split(' ');
                                      return Text(
                                        fieldData[1]== 'Positive'?'+ve':'-ve',
                                        style: GoogleFonts.poppins(
                                            fontSize: 35, fontWeight: FontWeight.bold),
                                      );
                                    }
                                    return const Text("...",);
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: height*.017333),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16)),
                      child: SizedBox(
                          height: height * .14,
                          width: width,
                          child: Image.asset("assets/images/blood.png",fit: BoxFit.cover,)),
                    ),

                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: ExpandingDotsEffect(
          dotWidth: 10, activeDotColor: theme, dotColor: theme, dotHeight: 10),
      activeIndex: activeIndex,
      count: images.length);

  Widget buildImage(String image, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
}