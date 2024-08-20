import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import '../constants/free_video.dart';
import '../screens/video_screen/video_screen.dart';

class CarouselSliderCard extends StatefulWidget {
  const CarouselSliderCard({super.key});

  @override
  State<CarouselSliderCard> createState() => _CarouselSliderCardState();
}

class _CarouselSliderCardState extends State<CarouselSliderCard> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return buildSlider(index);
        },
        options: CarouselOptions(
            enlargeCenterPage: true,
            scrollPhysics: ClampingScrollPhysics(),
            aspectRatio: 1.18,
            enableInfiniteScroll: false));
  }

  Widget buildSlider(int index) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return VideoPlayerScreen(
              video: video[index], title: title[index], desc: desc[index]);
        },
      )),
      child: Container(
        margin: const EdgeInsets.only(left: 4, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(workoutCardImages[index]),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                // padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                              "Total Body Transformation: 7-Day Workout Plan for Results",
                              style: GoogleFonts.oswald(
                                  fontSize: 16, color: Colors.white)),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/profile.png"),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Thomas",
                                  style: GoogleFonts.oswald(
                                      fontSize: 16, color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
