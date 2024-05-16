import 'dart:ui';

import 'package:fitness_app/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/free_video.dart';

class FreeContentWorkout extends StatefulWidget {
  const FreeContentWorkout({super.key});

  @override
  State<FreeContentWorkout> createState() => _FreeContentWorkoutState();
}

class _FreeContentWorkoutState extends State<FreeContentWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Free Content",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                          video: video[index],
                          desc: desc[index],
                          title: title[index]),
                    )),
                child: Container(
                  height: 300,
                  margin: EdgeInsets.only(left: 15, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(workoutCardImages[index]),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 15),
                        //color: Colors.blue,
                        width: double.infinity,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.favorite_outline_sharp,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: const Column(
                                children: [
                                  Text(
                                    "Hello",
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        },
      ),
    );
  }
}
