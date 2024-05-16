import 'package:fitness_app/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.isImage});
  final Message message;
  final bool isMe;
  final isImage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
            color: isMe
                ? Color.fromRGBO(27, 88, 231, 1)
                : Color.fromRGBO(30, 32, 33, 1)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isImage
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                message.content,
                              ),
                              fit: BoxFit.cover)),
                    )
                  : Text(
                      message.content,
                      style: GoogleFonts.oswald(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
              SizedBox(height: 5),
              Text(
                timeago.format(
                  message.sentTime,
                ),
                style: GoogleFonts.oswald(
                    color: Colors.white, fontWeight: FontWeight.normal),
              )
            ]),
      ),
    );
  }
}
