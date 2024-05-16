import 'package:fitness_app/chat/chat_screen.dart';
import 'package:fitness_app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});
  final UserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatScreen(userId: widget.user.uid),
      )),
      child: ListTile(
          iconColor: Colors.white,
          leading: Image.network(widget.user.image),
          title: Text(
            widget.user.name,
            style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.normal),
          ),
          subtitle: Text(
            "Your diet plan I will provide you on Monday...",
            style: GoogleFonts.oswald(
                color: Colors.white, fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            "15:30",
            style: GoogleFonts.oswald(
                color: Colors.white, fontWeight: FontWeight.w300),
          )),
    );
  }
}
