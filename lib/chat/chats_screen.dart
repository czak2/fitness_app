import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/chat/firebase_provider.dart';
import 'package:fitness_app/chat/message.dart';
import 'package:fitness_app/chat/notification_service.dart';
import 'package:fitness_app/chat/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final notificationService = NotificationServices();
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();

    notificationService.firebaseNotification(context);
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: SvgPicture.asset("assets/images/logo.svg"),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_none,
                size: 25,
              ),
            )
          ],
          backgroundColor: Colors.black,
        ),
        body: Consumer<FirebaseProvider>(
          builder: (context, value, child) => value.users.length == 1
              ? Center(
                  child: Text(
                    "No Users Yet",
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: value.users.length,
                  itemBuilder: (context, index) {
                    final user = value.users[index];
                    return value.users[index].uid !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? FutureBuilder<Message?>(
                            future: FirebaseProvider.getLatestMessageForUser(
                                user.uid),
                            builder: (context, snapshot) {
                              final latestMessage = snapshot.data;
                              return GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      userId: value.users[index].uid),
                                )),
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(30, 32, 33, 1)),
                                  child: ListTile(
                                      iconColor: Colors.white,
                                      leading: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 43,
                                          height: 43,
                                          child: Image.network(
                                            value.users[index].image,
                                            fit: BoxFit.cover,
                                          )),
                                      title: Text(
                                        value.users[index].name,
                                        style: GoogleFonts.oswald(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      subtitle: latestMessage != null
                                          ? Text(
                                              latestMessage.content,
                                              style: GoogleFonts.oswald(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          : Text(
                                              "",
                                              style: GoogleFonts.oswald(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                      trailing: Text(
                                        "",
                                        style: GoogleFonts.oswald(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      )),
                                ),
                              );
                            },
                          )
                        : SizedBox();
                  },
                ),
        ));
  }
}
