import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/chat/firebase_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'chat_screen.dart';

class NotificationServices {
  static const key =
      "AAAARs6q1oI:APA91bGVSG8W8ZgZVgAbcpcGRl-rHpjRuokdm9RBfiTxpsx_9_IWZpkd-nw8O5mHAHlDjJCvu4cv9Jd63tTLbIWeKQIQ47zjIg9ViguSFV5sqy9mdRxQFXH24NtE0rQm2z8zdPpZK0t2";
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void _initLocalNotification() {
    const androidSetting = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );
    const initializeSetting = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializeSetting,
      onDidReceiveNotificationResponse: (response) {
        debugPrint(response.payload.toString());
      },
    );
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
        "com.example.fitnessapp.urgent", "mychannelid",
        importance: Importance.max,
        styleInformation: styleInformation,
        priority: Priority.max);
    const iosDetails =
        DarwinNotificationDetails(presentAlert: true, presentBadge: true);
    final notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: message.data["body"]);
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

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    _saveToken(token!);
  }

  Future<void> _saveToken(String token) async =>
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"token": token}, SetOptions(merge: true));
  String receiverToken = "";
  Future<void> getReceiverToken(String? receiverId) async {
    final getToken = await FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .get();

    receiverToken = await getToken.data()!['token'];
  }

  void firebaseNotification(context) {
    _initLocalNotification();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(userId: message.data['senderId']),
        ),
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showLocalNotification(message);
    });
  }

  Future<void> sendNotification(
      {required String body, required String senderId}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$key',
        },
        body: jsonEncode(<String, dynamic>{
          "to": receiverToken,
          'priority': 'high',
          'notification': <String, dynamic>{
            'body': body,
            'title': 'New Message !',
          },
          'data': <String, String>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'senderId': senderId,
          }
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
