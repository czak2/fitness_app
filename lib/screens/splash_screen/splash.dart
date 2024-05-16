import 'dart:async';
import 'package:fitness_app/screens/profiles_screen/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/screens/home_screens/home_first.dart';
import 'package:fitness_app/screens/onboard_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../chat/firebase_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // final auth = FirebaseAuth.instance;
    // final user = auth.currentUser;
    // ;
    // //late final u = auth.currentUser!.uid;
    // //Provider.of<FirebaseProvider>(context, listen: false).currentUser(u);

    // Timer(const Duration(seconds: 4), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) {
    //       if (user != null)
    //         return HomeScreen(
    //           imgUrl: "",
    //         );
    //       return OnBoardingScreen();
    //     },
    //   ));
    // });
    Timer(Duration(seconds: 4), navigateUser);
    super.initState();
  }

  void navigateUser() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final prefs = await SharedPreferences.getInstance();
    final bool updateCompleted = prefs.getBool('updateComplete') ?? false;

    if (user != null && !updateCompleted) {
      // If user is logged in and update is not completed, navigate to UpdateScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
      );
    } else if (user != null && updateCompleted) {
      // If user is logged in and update is completed, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  imgUrl: "",
                )),
      );
    } else {
      // If user is not logged in or update is not completed, navigate to OnBoardingScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(child: SvgPicture.asset("assets/images/splash.svg")),
    );
  }
}
