import 'package:fitness_app/chat/chat_messages.dart';
import 'package:fitness_app/chat/chat_text_field.dart';
import 'package:fitness_app/chat/firebase_provider.dart';
import 'package:fitness_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});
  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Consumer<FirebaseProvider>(
          builder: (context, value, child) => value.user != null
              ? Text(
                  value.user!.name.toUpperCase(),
                  style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                )
              : SizedBox(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(recieverId: widget.userId),
            ChatTextField(
              recieverId: widget.userId,
            )
          ],
        ),
      ),
    );
  }
}
 // latestMessage != null
                                //     ? Text(
                                //         latestMessage.content,
                                //         style: TextStyle(color: Colors.white),
                                //       )
                                //     : Text(
                                //         "",
                                //         style: TextStyle(color: Colors.white),
                                //       ),
                                // Text(
                                //   value.latestMessages[
                                //           value.users[index].uid] ??
                                //       "",
                                //   style: GoogleFonts.oswald(
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.w300),
                                // ),