import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/chat/firebase_provider.dart';
import 'package:fitness_app/screens/favourite_screen/favorite_screen.dart';
import 'package:fitness_app/screens/workout_purchase_screen/my_program.dart';
import 'package:fitness_app/screens/authen_screen/phone_num_auth.dart';
import 'package:fitness_app/screens/workout_screen/workout_front.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/workout_screen/add_workout_details_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, top: 50, right: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<FirebaseProvider>(
                  builder: (context, value, child) {
                    return Container(
                        height: 90,
                        width: 90,
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(value.cUser!.image)));
                  },

                  // child: StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection("user")
                  //       .where("userId", isEqualTo: userId!.uid)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData && snapshot.data != null) {
                  //       return CircleAvatar(
                  //           radius: 25,
                  //           backgroundColor: Colors.black,
                  //           backgroundImage: NetworkImage(
                  //               snapshot.data!.docs[0]["imageUrl"]));
                  //     }
                  //     return Container();
                  //   },
                  //)
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.cancel_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<FirebaseProvider>(
              builder: (context, value, child) {
                return Container(
                  child: Text(
                    value.cUser!.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              },

              //     child:
              // StreamBuilder(
              //   stream: FirebaseFirestore.instance
              //       .collection("user")
              //       .where("userId", isEqualTo: userId!.uid)
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData && snapshot.data != null) {
              //       return Text(
              //         snapshot.data!.docs[0]["name"],
              //         style: const TextStyle(
              //             fontSize: 30,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white),
              //       );
              //     }
              //     return Container();
              //   },
              // )
              // Text(
              //   "Thomas",
              //   style: TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.my_library_books,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyProgram(),
                          ));
                    },
                    child: Text(
                      "My Program",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddWorkoutScreen(),
                          ));
                    },
                    child: Text(
                      "Health Regime",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.video_library_sharp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteScreen(),
                          ));
                    },
                    child: Text(
                      "Favourite Videos",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(),
                            content: Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Are you sure ",
                                    style: GoogleFonts.oswald(fontSize: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VerifyPhone()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          } on FirebaseAuthException catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        e.message.toString())));
                                          }
                                        },
                                        child: Text(
                                          "YES",
                                          style: GoogleFonts.oswald(
                                              fontSize: 16, color: Colors.blue),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "NO",
                                          style: GoogleFonts.oswald(
                                              fontSize: 16, color: Colors.red),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      // FirebaseAuth.instance.signOut();
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => VerifyPhone(),
                      //     ));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
