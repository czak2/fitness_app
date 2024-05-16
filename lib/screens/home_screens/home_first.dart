import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/chat/chats_screen.dart';
import 'package:fitness_app/screens/setting_screen/settingpage.dart';
import 'package:fitness_app/screens/workout_screen/workout_front.dart';
import 'package:flutter/material.dart';

import 'package:fitness_app/screens/home_screens/main_home_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../chat/firebase_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);
  final String imgUrl;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    p();

    super.initState();
  }

  void p() async {
    final auth = FirebaseAuth.instance;
    final u = auth.currentUser!.uid;
    await Provider.of<FirebaseProvider>(context, listen: false).currentUser(u);
  }

  int selectedIndex = 0;

  List data = [
    "assets/icons/home-2.svg",
    "assets/icons/weight-2.svg",
    "assets/icons/messages1.svg",
    "assets/icons/setting.svg",
  ];
  int currentIndex = 0;
  late List<Widget> page = [
    MainHomePage(imgUrl: widget.imgUrl),
    const AddWorkoutScreen(),
    const ChatsScreen(),
    const SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Container(
      //       margin: const EdgeInsets.only(right: 10),
      //       child: const Icon(
      //         Icons.notifications,
      //         size: 33,
      //       ),
      //     )
      //   ],
      //   title: const Center(
      //     child: Text(
      //       "Duty Time",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      //   backgroundColor: Colors.black,
      //   leading: Container(
      //       margin: EdgeInsets.only(left: 10),
      //       child: widget.imgUrl.length > 10
      //           ? CircleAvatar(
      //               radius: 25,
      //               backgroundColor: Colors.black,
      //               backgroundImage: NetworkImage(widget.imgUrl))
      //           : CircleAvatar(
      //               child: Image.asset("assets/images/profile.png"))),
      // ),
      backgroundColor: Colors.transparent,

      body: page[selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(27, 88, 231, 1),
                    Color.fromRGBO(16, 71, 199, 1),
                  ]),
              borderRadius: BorderRadius.circular(20)),
          // color: Color.fromRGBO(27, 88, 231, 1),
          child: Container(
            height: 55,
            width: double.infinity,
            child: ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: 40,
                    decoration: BoxDecoration(
                      border: i == selectedIndex
                          ? Border(
                              top: BorderSide(width: 3.0, color: Colors.white))
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          data[i],
                          width: 25,
                          color: i == selectedIndex
                              ? Colors.white
                              : Colors.white24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),

      // ClipRRect(
      //   borderRadius: BorderRadius.circular(25),
      //   child: BottomNavigationBar(
      //       currentIndex: currentIndex,
      //       onTap: (value) {
      //         setState(() {
      //           currentIndex = value;
      //         });
      //       },
      //       type: BottomNavigationBarType.fixed,
      //       selectedItemColor: Colors.black,
      //       unselectedItemColor: Colors.white,
      //       backgroundColor: Colors.blue.shade800,
      //       items: [
      //         BottomNavigationBarItem(
      //             label: "",
      //             icon: Icon(
      //               Icons.home,
      //             )),
      //         BottomNavigationBarItem(
      //             label: "",
      //             icon: SvgPicture.asset("assets/icons/weight-1.svg")),
      //         // BottomNavigationBarItem(label: "", icon: Icon(Icons.chat)),
      //         BottomNavigationBarItem(label: "", icon: Icon(Icons.settings)),
      //       ]),
      // ),
    );
  }
}
