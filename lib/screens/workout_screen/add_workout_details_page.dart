import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';

class AddWorkoutDetailsPage extends StatefulWidget {
  const AddWorkoutDetailsPage({super.key});

  @override
  State<AddWorkoutDetailsPage> createState() => _AddWorkoutDetailsPageState();
}

class _AddWorkoutDetailsPageState extends State<AddWorkoutDetailsPage> {
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String dropDownValue = "PushUps";
  List<Map<String, dynamic>> workoutDetails = [];

  void addWorkout() {
    var name = dropDownValue;
    var reps = repsController.text.trim();
    var cal = caloriesController.text.trim();
    var weight = weightController.text.trim();

    if (name.isNotEmpty &&
        reps.isNotEmpty &&
        cal.isNotEmpty &&
        weight.isNotEmpty) {
      workoutDetails.add({
        "name": name,
        "reps": reps,
        "cal": cal,
        "weight": weight,
      });
      // Clear fields for new input
      repsController.clear();
      weightController.clear();
      caloriesController.clear();
      setState(() {
        dropDownValue = "PushUps"; // Reset to default value
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter required fields")),
      );
    }
  }

  void saveWorkouts() async {
    // Add current workout data to the list if the fields are not empty
    addWorkout();

    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance.collection("workout").add({
        "userId": userId!.uid,
        "workouts": workoutDetails,
        "createdAt": DateTime.now(),
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text("Add Health Regime",
              style: GoogleFonts.oswald(
                  fontWeight: FontWeight.w600, color: Colors.white)),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 11, top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 60,
                  width: double.infinity,
                  child: DropdownButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 270),
                      child: SvgPicture.asset(
                        "assets/icons/arrow-right.svg",
                        color: Color.fromRGBO(28, 28, 28, 1),
                      ),
                    ),
                    style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(27, 88, 231, 1)),
                    value: dropDownValue,
                    items: [
                      DropdownMenuItem(
                          value: "PushUps",
                          child: Text(
                            "PushUps",
                            style: GoogleFonts.oswald(),
                          )),
                      DropdownMenuItem(
                          value: "Squats",
                          child: Text("Squats", style: GoogleFonts.oswald())),
                      DropdownMenuItem(
                          value: "Deadlift",
                          child: Text("Deadlift", style: GoogleFonts.oswald())),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: repsController,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Number of Reps",
                      hintStyle: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(27, 88, 231, 1)),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Weight",
                      hintStyle: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(27, 88, 231, 1)),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: caloriesController,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Calories",
                      hintStyle: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(27, 88, 231, 1)),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: addWorkout,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(30, 32, 33, 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text(
                          "Add more exercise",
                          style: GoogleFonts.oswald(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(27, 88, 231, 1),
                        ),
                      )
                    : CustomButon(
                        title: "Save",
                        onPressed: saveWorkouts,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
