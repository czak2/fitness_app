import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String video;
  final String title;
  final String desc;
  const VideoPlayerScreen({
    Key? key,
    required this.video,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //late String assetsVideo=widget.video;
  late final FlickManager flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(widget.video));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        //actionsIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.title,
                    style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 15,
                ),
                Text(widget.desc,
                    style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
