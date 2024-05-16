import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'add_workout_details_page.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          height: 40,
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddWorkoutDetailsPage(),
                )),
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(30, 32, 33, 1)),
                margin: EdgeInsets.only(right: 15, bottom: 4),
                child: const Icon(
                  color: Colors.white,
                  Icons.add,
                  size: 30,
                )),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("workout")
              .where("userId", isEqualTo: userId!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text(
                "Please add workout",
                style: GoogleFonts.oswald(color: Colors.white),
              ));
            }
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DateTime createdAt =
                      snapshot.data!.docs[index]['createdAt'].toDate();
                  String formattedDate =
                      DateFormat('MMMM dd').format(createdAt);

                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(30, 32, 33, 1)),
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        height: 211,
                        width: 328,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              formattedDate,
                              style: GoogleFonts.oswald(
                                  fontSize: 22, color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.docs[index]["name"],
                                    style: GoogleFonts.oswald(
                                        fontSize: 22, color: Colors.white)),
                                Text(
                                    snapshot.data!.docs[index]["reps"] +
                                        " Reps",
                                    style: GoogleFonts.oswald(
                                        fontSize: 22, color: Colors.white))
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       snapshot.data!.docs[index]["name"],
                            //       style: TextStyle(fontSize: 22),
                            //     ),
                            //     Text("20 reps", style: TextStyle(fontSize: 22))
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(27, 88, 231, 1),
                                            Color.fromRGBO(16, 71, 199, 1)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/we.svg",
                                            width: 16,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                    ["weight"] +
                                                " Lbs",
                                            style: GoogleFonts.oswald(
                                                fontSize: 13,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: 40,
                                      width: 111,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(231, 177, 27, 1),
                                            Color.fromRGBO(255, 51, 0, 1)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/ht.svg",
                                            width: 11,
                                            height: 16,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]["cal"] +
                                                " Calories",
                                            style: GoogleFonts.oswald(
                                                fontSize: 13,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
      // body:
      // Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(30), color: Colors.blueGrey),
      //   margin: EdgeInsets.only(left: 15, right: 15),
      //   height: 250,
      //   width: double.infinity,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Center(
      //           child: Text(
      //         "May 08 2023",
      //         style: TextStyle(fontSize: 22),
      //       )),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Text(
      //             "Push-Up",
      //             style: TextStyle(fontSize: 22),
      //           ),
      //           Text("12 reps", style: TextStyle(fontSize: 22))
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Text(
      //             "Pull-Ups",
      //             style: TextStyle(fontSize: 22),
      //           ),
      //           Text("20 reps", style: TextStyle(fontSize: 22))
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Container(
      //                 height: 40,
      //                 width: 80,
      //                 decoration: BoxDecoration(
      //                     color: Colors.blue,
      //                     borderRadius: BorderRadius.circular(22)),
      //                 child: Row(
      //                   children: [Icon(Icons.monitor_weight), Text("150 lbs")],
      //                 ),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Container(
      //                 height: 40,
      //                 width: 80,
      //                 decoration: BoxDecoration(
      //                     color: Colors.orange,
      //                     borderRadius: BorderRadius.circular(22)),
      //                 child: Row(
      //                   children: [Icon(Icons.monitor_weight), Text("150 lbs")],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
