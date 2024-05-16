import 'package:fitness_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkoutDetailsPage extends StatefulWidget {
  const WorkoutDetailsPage(
      {super.key,
      required this.title,
      required this.img,
      required this.instructorName,
      required this.date,
      required this.description,
      required this.onTap,
      required this.buttonT});
  final String title;
  final String img;
  final String instructorName;
  final String date;
  final String description;
  final VoidCallback onTap;
  final String buttonT;
  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  // late String buttonText;
  late bool _isPurchased;

  @override
  void initState() {
    super.initState();
    _isPurchased = widget.buttonT == "Purchased";
  }

  // void updateButtonText() {
  //   setState(() {
  //     buttonText = "Purchased";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.img), fit: BoxFit.cover),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title,
                      style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(
                    widget.date,
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Text(
                "Duration 60 days",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 70,
                    // color: Colors.green,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/profile.png"))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.instructorName,
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text("8 years Experience",
                          style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.description,
                style: GoogleFonts.oswald(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.diamond,
                        size: 50,
                      ),
                      Text(
                        "\$ 15.99",
                        style: GoogleFonts.oswald(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Only one time payment",
                        style: GoogleFonts.oswald(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButon(
                  title: _isPurchased ? "Purchased" : widget.buttonT,
                  onPressed: () {
                    _isPurchased
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(),
                                content: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Already Purchased",
                                        style: GoogleFonts.oswald(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirm Purchase'),
                                content:
                                    Text('Are you sure you want to purchase?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _isPurchased = true;
                                      });
                                      widget.onTap();

                                      // updateButtonText();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                  },

                  // isPurchase
                  //     ? null
                  //     : showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return AlertDialog(
                  //             shape: RoundedRectangleBorder(),
                  //             content: Container(
                  //               height: 100,
                  //               child: Column(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     "Are you sure ",
                  //                     style:
                  //                         GoogleFonts.oswald(fontSize: 20),
                  //                   ),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       InkWell(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             isPurchase = true;
                  //                             Navigator.pop(context);
                  //                           });
                  //                         },
                  //                         child: Text(
                  //                           "YES",
                  //                           style: GoogleFonts.oswald(
                  //                               fontSize: 20,
                  //                               color: Colors.blue),
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           Navigator.pop(context);
                  //                         },
                  //                         child: Text(
                  //                           "NO",
                  //                           style: GoogleFonts.oswald(
                  //                               fontSize: 20,
                  //                               color: Colors.red),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
