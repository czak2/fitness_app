import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fitness_app/screens/favourite_screen/add_fav.dart';
import 'package:fitness_app/screens/notification_screen/notification_screen.dart';
import 'package:fitness_app/widgets/carousel_slider.dart';

import 'package:fitness_app/widgets/main_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../chat/firebase_provider.dart';
import '../../widgets/drawer.dart';
import '../../widgets/home_page_listview.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late final uId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FirebaseProvider>(context, listen: false).getUserById(uId);

    super.initState();
  }

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
            height: MediaQuery.of(context).size.height / 1.3,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Drawer(
                child: DrawerWidget(),
                backgroundColor: const Color.fromARGB(255, 33, 86, 243),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotiScreen(),
                    ));
              },
              child: const Icon(
                Icons.notifications,
                size: 33,
              ),
            ),
          )
        ],
        title: Center(
            child: SvgPicture.asset(
          "assets/images/logo.svg",
          height: 40,
        )),
        backgroundColor: Colors.black,
        leading: Builder(builder: (context) {
          return InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Consumer<FirebaseProvider>(
                builder: (context, value, child) {
                  return value.cUser != null
                      ? Container(
                          margin: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(value.cUser!.image)),
                        )
                      : SizedBox();
                },
              ));
        }),
      ),
      body: SingleChildScrollView(
        child: Consumer<FirebaseProvider>(
          builder: (context, value, child) {
            return value.cUser != null
                ? Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Good Morning",
                          style: GoogleFonts.oswald(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        Container(
                          child: Text(value.cUser!.name,
                              style: GoogleFonts.oswald(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          padding: EdgeInsets.only(left: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 32, 33, 1),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Get up with",
                                    style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "MY DAILY REGIME",
                                    style: GoogleFonts.oswald(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(27, 88, 231, 1),
                                        Color.fromRGBO(16, 71, 199, 1),
                                      ]),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Icon(
                                    Icons.open_in_new,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FREE CONTENT",
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 20),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FreeContent(),
                                    ));
                              },
                              child: Text(
                                "See all",
                                style: GoogleFonts.oswald(
                                  color: Colors.white.withOpacity(0.56),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CarouselSliderCard(),
                        SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 124,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(232, 189, 112, 1),
                                  Color.fromRGBO(237, 209, 133, 1)
                                ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                SvgPicture.asset("assets/icons/people.svg"),
                                Text("MEMBER JONE",
                                    style: GoogleFonts.oswald(
                                        fontSize: 26,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text("Enjoy discount and special offer",
                                    style: GoogleFonts.oswald(
                                      color: Colors.black.withOpacity(0.7),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        HomeListView()
                      ],
                    ),
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }
}
