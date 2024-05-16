import 'package:fitness_app/constants/workout_listview_data.dart';
import 'package:fitness_app/provider/favourite_video.dart';
import 'package:fitness_app/provider/my_program_provider.dart';
import 'package:fitness_app/provider/payment_history.dart';
import 'package:fitness_app/screens/home_screens/home_first.dart';
import 'package:fitness_app/screens/workout_purchase_screen/workout_purchase.dart';
import 'package:fitness_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  final List img = [
    "assets/images/workoutlist1.jpg",
    "assets/images/workoutlist2.jpg",
    "assets/images/workoutlist3.jpg"
  ];
  final List title = [
    "8 weeks home leg builder",
    "8 weeks back workout",
    "8 weeks chest workout",
  ];
  final List desc = [
    "When it comes to leg workouts, variety is key. Your quads, hamstrings and glutes are made up of multiple muscles, which are responsible for multiple lower-body functions, so it’s important to have multiple leg exercises in your arsenal and train legs holistically. Going through the motions and performing the same movements, day after day and week after week, isn’t going to cut it here. Don't believe us? Well, according to new research, when it comes to exercises and muscle strength, variety really is the spice of life.",
    "The back isn’t only one of the body’s biggest and strongest body parts, it’s also the most complicated in terms of being a series of interconnected muscle groups. For the purposes of this feature, we’re dividing the back into its four main regions:\nUpper and outer lats\nLower lats\nMiddle back\nLower back\nEach area requires specific stimulation via the exercises and angles of attack used, and we’ll show you the two best back exercises for each.",
    "For body builders and those interested in general muscular aesthetics, the chest muscles are the defining part of muscle mass. Powerlifters rely on them for the bench press to score the greatest lift.But these muscles are also incredibly important from a functional standpoint because they support the movement of the arms.A number of studies examining perceived attractiveness found that a low waist-to-chest ratio was rated as the most attractive physical feature on males (1Trusted Source). This is when a person has a narrower waist and broader chest."
  ];
  List<String> items = [
    "Buy Now",
    "Buy Now",
    "Buy Now",
  ];
  //late List<String> items;
  @override
  void initState() {
    super.initState();

    loaditems();
  }

  Future<void> loaditems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      items = prefs.getStringList("items") ?? ["Buy Now", "Buy Now", "Buy Now"];
    });
  }

  Future<void> saveitems(List<String> updatedItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("items", updatedItems);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailsPage(
                    buttonT: items[index],
                    onTap: () {
                      setState(() {
                        items[index] = "Purchased";
                        saveitems(items);
                        Provider.of<MyProgramProvider>(context, listen: false)
                            .addMyProgram(img[index]);
                        Provider.of<PaymentHistoryProvider>(context,
                                listen: false)
                            .addPayment(
                                "Payment History", title[index], "\$15.99");
                      });
                      //   items[index] == "Purchased"
                      //       ? showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return AlertDialog(
                      //               shape: RoundedRectangleBorder(),
                      //               content: Container(
                      //                 height: 100,
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Text(
                      //                       "Already Purchased",
                      //                       style:
                      //                           GoogleFonts.oswald(fontSize: 20),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         )
                      //       : showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return AlertDialog(
                      //               shape: RoundedRectangleBorder(),
                      //               content: Container(
                      //                 height: 100,
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Text(
                      //                       "Are you sure ",
                      //                       style:
                      //                           GoogleFonts.oswald(fontSize: 20),
                      //                     ),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         InkWell(
                      //                           onTap: () {
                      //                             setState(() {
                      //                               items[index] = "Purchased";
                      //                               saveitems(items);
                      //                             });
                      //                             Navigator.pushReplacement(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       HomeScreen(
                      //                                           imgUrl: ""),
                      //                                 ));
                      //                           },
                      //                           child: Text(
                      //                             "YES",
                      //                             style: GoogleFonts.oswald(
                      //                                 fontSize: 20,
                      //                                 color: Colors.blue),
                      //                           ),
                      //                         ),
                      //                         InkWell(
                      //                           onTap: () {
                      //                             Navigator.pop(context);
                      //                           },
                      //                           child: Text(
                      //                             "NO",
                      //                             style: GoogleFonts.oswald(
                      //                                 fontSize: 20,
                      //                                 color: Colors.red),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                    },
                    img: img[index],
                    date: "10 June 2023",
                    description: desc[index],
                    instructorName: "Dan Alvarado",
                    title: title[index],
                  ),
                ));
          },
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      img[index],
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
                            child: Image.asset("assets/images/profile.png"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
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
                            width: MediaQuery.of(context).size.width * 0.12,
                          ),
                        ],
                      )),
                  Positioned(
                      left: 60,
                      right: 60,
                      bottom: 1,
                      child: CustomButon(
                          title: items[index],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkoutDetailsPage(
                                    buttonT: items[index],
                                    onTap: () {},
                                    img: img[index],
                                    date: "10 June 2023",
                                    description: desc[index],
                                    instructorName: "Dan Alvarado",
                                    title: title[index],
                                  ),
                                ));
                          }))
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
