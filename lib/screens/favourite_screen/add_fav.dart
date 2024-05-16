import 'dart:ui';

import 'package:fitness_app/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../constants/free_video.dart';
import '../../provider/favourite_video.dart';

class FreeContent extends StatefulWidget {
  const FreeContent({super.key});

  @override
  State<FreeContent> createState() => _FreeContentState();
}

class _FreeContentState extends State<FreeContent> {
  List<bool> isFavorite = [false, false, false];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 3; i++) {
      bool? isFavorited = prefs.getBool('isFavorite_$i');
      if (isFavorited != null) {
        setState(() {
          isFavorite[i] = isFavorited;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Free Content",
            style: GoogleFonts.oswald(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {},
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return VideoPlayerScreen(
                      video: video[index],
                      title: title[index],
                      desc: desc[index]);
                },
              )),
              child: Container(
                height: 400,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(workoutCardImages[index]),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 15,
                      child: InkWell(
                        onTap: isFavorite[index] == false
                            ? () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                bool isFavorited = !isFavorite[index];
                                prefs.setBool('isFavorite_$index', isFavorited);
                                setState(() {
                                  isFavorite[index] = isFavorited;
                                });
                                String titl = title[index];
                                String d = desc[index];
                                String v = video[index];
                                String cardImage = workoutCardImages[index];
                                Provider.of<FavoriteVideosModel>(context,
                                        listen: false)
                                    .addFavoriteVideo(cardImage, titl, d, v);
                              }
                            : () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                bool isFavorited = !isFavorite[index];
                                prefs.setBool('isFavorite_$index', isFavorited);
                                setState(() {
                                  isFavorite[index] = isFavorited;
                                });
                                String cardImage = workoutCardImages[index];
                                Provider.of<FavoriteVideosModel>(context,
                                        listen: false)
                                    .removeFavoriteVideo(cardImage);
                              },
                        child: Container(
                            // padding: EdgeInsets.only(left: 5),
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white.withOpacity(0.1)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Icon(
                                    Icons.favorite,
                                    color: isFavorite[index]
                                        ? Colors.red
                                        : Colors.white.withOpacity(0.10),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            // padding: EdgeInsets.only(left: 5),
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            height: 110,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white.withOpacity(0.1)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                          "Total Body Transformation: 7-Day Workout Plan for Results",
                                          style: GoogleFonts.oswald(
                                              fontSize: 16,
                                              color: Colors.white)),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/images/profile.png"),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("Thomas",
                                              style: GoogleFonts.oswald(
                                                  fontSize: 16,
                                                  color: Colors.white))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
