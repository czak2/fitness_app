import 'package:fitness_app/provider/favourite_video.dart';
import 'package:fitness_app/provider/my_program_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProgram extends StatefulWidget {
  const MyProgram({super.key});

  @override
  State<MyProgram> createState() => _MyProgramState();
}

class _MyProgramState extends State<MyProgram> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyProgramProvider>(context, listen: false).loadMyProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "My Programs",
          style: GoogleFonts.oswald(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Consumer<MyProgramProvider>(
        builder: (context, value, child) {
          return value.myProgram.isEmpty
              ? Center(
                  child: Text(
                    "No Program Yet",
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: value.myProgram.length,
                  itemBuilder: (context, index) {
                    String cardImage = value.myProgram[index];
                    return Column(
                      children: [
                        Container(
                          height: 446,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  cardImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                  left: 15,
                                  bottom: 180,
                                  child: Text(
                                    "8 Week",
                                    style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                              Positioned(
                                  left: 15,
                                  bottom: 150,
                                  child: Text(
                                    "Duration 60 days",
                                    style: GoogleFonts.oswald(
                                        color: Colors.white.withOpacity(0.60),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  )),
                              Positioned(
                                  left: 15,
                                  bottom: 90,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Image.asset(
                                            "assets/images/profile.png"),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Column(
                                        children: [
                                          Text("Dan Alvarado ",
                                              style: GoogleFonts.oswald(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          // Text("Hello World",
                                          //     style: TextStyle(color: Colors.white))
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
