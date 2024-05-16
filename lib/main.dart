import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_app/chat/firebase_provider.dart';
import 'package:fitness_app/provider/favourite_video.dart';
import 'package:fitness_app/provider/my_program_provider.dart';
import 'package:fitness_app/provider/payment_history.dart';
import 'package:fitness_app/screens/notification_screen/notification_screen.dart';
import 'package:fitness_app/screens/setting_screen/settingpage.dart';

import 'package:fitness_app/screens/splash_screen/splash.dart';
import 'package:fitness_app/screens/profiles_screen/update_profile.dart';
import 'package:fitness_app/screens/authen_screen/phone_num_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'chat/chats_screen.dart';
import 'firebase_options.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future multiRegister() async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.subscribeToTopic("bhaloop");
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteVideosModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyProgramProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentHistoryProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Fitness',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          // initialRoute: "/",
          // routes: {"/": (context) => Splash()},
          home: Splash()
          // BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
          //   buildWhen: (previous, current) {
          //     return previous is PhoneAuthInitial;
          //   },
          //   builder: (context, state) {
          //     if (state is AuthLoggedInState) {
          //       return HomeScreen();
          //     }
          //     return SplashScreen();
          //   },

          //      ),

          ),
    );
  }
}
