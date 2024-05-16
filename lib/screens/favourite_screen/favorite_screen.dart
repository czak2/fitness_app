import 'dart:ui';

import 'package:fitness_app/constants/free_video.dart';
import 'package:fitness_app/screens/favourite_screen/add_fav.dart';
import 'package:fitness_app/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/favourite_video.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FavoriteVideosModel>(context, listen: false)
        .loadFavoriteVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Free Content",
          style: GoogleFonts.oswald(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer<FavoriteVideosModel>(
        builder: (context, favoriteVideosModel, child) {
          return favoriteVideosModel.favoriteVideos.isEmpty
              ? Center(
                  child: Text(
                    "No Favorite Added",
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteVideosModel.favoriteVideos.length,
                  itemBuilder: (context, index) {
                    String cardImage =
                        favoriteVideosModel.favoriteVideos[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                  video: favoriteVideosModel.video[index],
                                  title: favoriteVideosModel.title[index],
                                  desc: favoriteVideosModel.desc[index]),
                            ));
                      },
                      child: Container(
                        height: 300,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(cardImage),
                                fit: BoxFit.cover)),
                        child: Column(
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
                                    filter: ImageFilter.blur(
                                        sigmaX: 15, sigmaY: 15),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 3, right: 3),
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
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
