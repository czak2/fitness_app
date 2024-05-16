import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/chat/notification_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/chat/firebase_firestore_service.dart';
import 'package:fitness_app/chat/media_service.dart';
import 'package:fitness_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.recieverId});
  final String recieverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  final notificationServices = NotificationServices();
  Uint8List? file;
  @override
  void initState() {
    // TODO: implement initState
    notificationServices.getReceiverToken(widget.recieverId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 20,
          child: IconButton(
              onPressed: () => _sendText(context),
              icon: SvgPicture.asset("assets/icons/gallery.svg")),
        ),
        Expanded(
            child: TextFormField(
          style: GoogleFonts.oswald(
            color: Colors.white,
          ),
          controller: controller,
          decoration: InputDecoration(
            hintText: "Type here...",
            hintStyle: GoogleFonts.oswald(color: Colors.white54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        )),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 20,
          child: IconButton(
              onPressed: () => _sendText(context),
              icon: SvgPicture.asset("assets/icons/send-2.svg")),
        ),
      ],
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
          content: controller.text, receiverId: widget.recieverId);
      await notificationServices.sendNotification(
        body: controller.text,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      controller.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _sendImage() async {
    final pickedImage = await MediaService.pickImage();
    setState(() {
      file = pickedImage;
    });
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
          receiverId: widget.recieverId, file: file!);
      await notificationServices.sendNotification(
        body: controller.text,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }
}
