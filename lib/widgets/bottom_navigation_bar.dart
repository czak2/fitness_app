import 'package:fitness_app/screens/home_screens/main_home_page.dart';

import 'package:flutter/material.dart';

import '../screens/workout_screen/workout_front.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;
  List<Widget> page = [MainHomePage(imgUrl: ""), AddWorkoutScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: page[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.blue.shade800,
            items: [
              BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    Icons.home,
                  )),
              BottomNavigationBarItem(
                  label: "", icon: Icon(Icons.monitor_weight)),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.chat)),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
            ]),
      ),
    );
  }
}
