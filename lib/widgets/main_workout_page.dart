import 'dart:ui';

import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/constants/free_video.dart';
import 'package:fitness_app/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWorkoutPageCard extends StatefulWidget {
  const MainWorkoutPageCard({super.key});

  @override
  State<MainWorkoutPageCard> createState() => _MainWorkoutPageCardState();
}

class _MainWorkoutPageCardState extends State<MainWorkoutPageCard> {
  PageController pageController = PageController(viewportFraction: 0.85);
  int currentPage = 0;
  double scaleFactor = 0.8;
  @override
  void initState() {
    pageController.addListener(() {
      if (pageController.page!.round() != currentPage) {
        setState(() {
          currentPage = pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: double.infinity,
      child: PageView.builder(
        controller: pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildPageItem(index);
        },
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == currentPage.floor()) {
      var currScale = 1 - (currentPage - index) * (1 - scaleFactor);
      var currTrans = 250 * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPage.floor() + 1) {
      var currScale =
          scaleFactor + (currentPage - index + 1) * (1 - scaleFactor);
      var currTrans = 250 * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    return Transform(
      transform: matrix4,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return VideoPlayerScreen(
                video: video[index], title: title[index], desc: desc[index]);
          },
        )),
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 10),
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
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "TOTAL TRASFORMATION",
                              style: GoogleFonts.oswald(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/profile.png"),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Thomas",
                                  style: GoogleFonts.oswald(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                )
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
      ),
    );
  }
}
