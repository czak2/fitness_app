import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../chat/notification_service.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<Map<String, String>> notifications = [];
  final notificationServices = NotificationServices();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    r();
    configureFirebaseMessaging();
    loadNotifications();
  }

  void r() async {
    await requestPermission();
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final setting = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("user granted permission");
    } else if (setting.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint("user granted provisional permission");
    } else {
      debugPrint("user decline the permission");
    }
  }

  void configureFirebaseMessaging() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Handle the initial message
        handleNotification(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle the incoming message
      handleNotification(message);
      await notificationServices.showLocalNotification(message);
    });
  }

  void handleNotification(RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotifications = prefs.getStringList('notifications');
    savedNotifications ??= [];
    savedNotifications
        .add('${message.notification?.title},${message.notification?.body}');
    await prefs.setStringList('notifications', savedNotifications);
    setState(() {
      notifications.add({
        'title': message.notification?.title ?? '',
        'message': message.notification?.body ?? '',
      });
    });
  }

  void loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load notifications from local storage
    List<String>? savedNotifications = prefs.getStringList('notifications');
    if (savedNotifications != null) {
      for (String notification in savedNotifications) {
        List<String> parts = notification.split(',');
        if (parts.length == 2) {
          setState(() {
            notifications.add({'title': parts[0], 'message': parts[1]});
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Notifications",
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(30, 32, 33, 1),
        ),
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  'No Notifications',
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(30, 32, 33, 1)),
                    child: ListTile(
                      iconColor: Colors.white,
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 43,
                        height: 43,
                        child: Icon(
                          Icons.notifications_none,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        notifications[index]['title'] ?? '',
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        notifications[index]['message'] ?? '',
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: Text(
                        '', // Add your trailing text here
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
