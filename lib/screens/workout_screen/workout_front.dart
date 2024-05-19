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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(30, 32, 33, 1),
            ),
            margin: EdgeInsets.only(right: 15, bottom: 4),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddWorkoutDetailsPage(),
                ),
              ),
              child: const Icon(
                color: Colors.white,
                Icons.add,
                size: 30,
              ),
            ),
          ),
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
              return Center(
                child: Text(
                  "Something went wrong",
                  style: GoogleFonts.oswald(color: Colors.white),
                ),
              );
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
                ),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              docs.sort((a, b) {
                Timestamp aTimestamp = a['createdAt'];
                Timestamp bTimestamp = b['createdAt'];
                return aTimestamp.compareTo(bTimestamp);
              });

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var doc = docs[index];
                  DateTime createdAt = (doc['createdAt'] as Timestamp).toDate();
                  String formattedDate =
                      DateFormat('MMMM dd').format(createdAt);

                  List<dynamic> workouts = doc['workouts'] ?? [];

                  if (workouts.isEmpty) return Container();

                  int totalWeight = 0;
                  int totalCalories = 0;
                  workouts.forEach((workout) {
                    totalWeight += int.tryParse(workout["weight"]) ?? 0;
                    totalCalories += int.tryParse(workout["cal"]) ?? 0;
                  });

                  return Column(
                    children: [
                      Container(
                        height: 211,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(30, 32, 33, 1),
                        ),
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: workouts.length == 1
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: [
                            Text(
                              formattedDate,
                              style: GoogleFonts.oswald(
                                  fontSize: 22, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            ...workouts.map((workout) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(workout["name"],
                                          style: GoogleFonts.oswald(
                                              fontSize: 22,
                                              color: Colors.white)),
                                      Text("${workout["reps"]} Reps",
                                          style: GoogleFonts.oswald(
                                              fontSize: 22,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(27, 88, 231, 1),
                                        Color.fromRGBO(16, 71, 199, 1)
                                      ]),
                                      borderRadius: BorderRadius.circular(22)),
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
                                        "$totalWeight Lbs",
                                        style: GoogleFonts.oswald(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 40,
                                  width: 111,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(231, 177, 27, 1),
                                        Color.fromRGBO(255, 51, 0, 1)
                                      ]),
                                      borderRadius: BorderRadius.circular(22)),
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
                                        "$totalCalories Calories",
                                        style: GoogleFonts.oswald(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
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
    );
  }
}
