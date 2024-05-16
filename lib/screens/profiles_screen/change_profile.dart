import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/chat/firebase_provider.dart';
import 'package:fitness_app/screens/setting_screen/settingpage.dart';
import 'package:fitness_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User? userId = FirebaseAuth.instance.currentUser;
  File? image;
  final picker = ImagePicker();
  bool isLoading = false;
  String imageUrl = "";
  Future getImageGall() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
      // else {
      //   image = File("assets/images/profile.png");
      // }
    });
  }

  Future getImageCam() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  void dialog(context) {
    showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(),
          content: Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    getImageCam();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImageGall();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Gallery"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .where("userId", isEqualTo: userId!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Text(
                "No data Found",
                style: TextStyle(color: Colors.white),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              // return Center(
              //   child: Text("Hello", style: TextStyle(color: Colors.white)),
              // );
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    String imageUrl = snapshot.data!.docs[index]["imageUrl"];
                    TextEditingController nameController =
                        TextEditingController(
                            text: snapshot.data!.docs[index]["name"]);
                    TextEditingController emailController =
                        TextEditingController(
                            text: snapshot.data!.docs[index]["emailId"]);
                    TextEditingController bioController = TextEditingController(
                        text: snapshot.data!.docs[index]["bio"]);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text("UPDATE PROFILE",
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                        InkWell(
                          onTap: () {
                            dialog(context);
                          },
                          child: Center(
                            child: Consumer<FirebaseProvider>(
                              builder: (context, value, child) {
                                return Container(
                                  //color: Colors.green,
                                  width: 200,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      image != null
                                          ? Center(
                                              child: Container(
                                                height: 136,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    image: DecorationImage(
                                                        image:
                                                            FileImage(image!),
                                                        fit: BoxFit.cover)),
                                              ),
                                            )
                                          : Center(
                                              child: Container(
                                                height: 136,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            value.cUser!.image),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                      Positioned(
                                          left: 80,
                                          bottom: 10,
                                          child: Icon(
                                            Icons.camera_enhance,
                                            size: 40,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            style: GoogleFonts.oswald(),
                            maxLength: 50,
                            //controller: phoneController,
                            controller: nameController,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "Full Name",
                                hintStyle: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 88, 231, 1)),
                                // label: const Text(
                                //   "Full Name",
                                //   style: TextStyle(fontSize: 15),
                                // ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.blue)),
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(color: Colors.blue),
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            style: GoogleFonts.oswald(),
                            maxLength: 50,
                            //controller: phoneController,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "EmailId",
                                hintStyle: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 88, 231, 1)),
                                // label: const Text(
                                //   "Email Id",
                                //   style: TextStyle(fontSize: 15),
                                // ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.blue)),
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(color: Colors.blue),
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                          child: TextFormField(
                            maxLines: 20,

                            style: GoogleFonts.oswald(),
                            //controller: phoneController,
                            controller: bioController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "Bio",
                                hintStyle: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 88, 231, 1)),
                                // label: const Text(
                                //   "Bio",
                                //   style: TextStyle(fontSize: 15),
                                // ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.blue)),
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(color: Colors.blue),
                                prefixIcon: const Icon(Icons.note_alt),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        isLoading == false
                            ? Center(
                                child: CustomButon(
                                title: "UPDATE",
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (image == null) {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        "name": nameController.text.trim(),
                                        "emailId": emailController.text.trim(),
                                        "bio": bioController.text.trim(),
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(_scaffoldKey.currentContext!)
                                          .pop();
                                    } on FirebaseAuthException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text(e.message.toString())));
                                    }
                                  } else {
                                    String uniquie = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceImage =
                                        referenceRoot.child("images");
                                    Reference referenceImageToUpload =
                                        referenceImage.child(uniquie);

                                    try {
                                      // Reference referenceImageToUpload =
                                      //     FirebaseStorage.instance.refFromURL(
                                      //         snapshot.data!
                                      //             .docs[index]["imageUrl"]
                                      //             .toString());

                                      await referenceImageToUpload
                                          .putFile(File(image!.path));
                                      imageUrl = await referenceImageToUpload
                                          .getDownloadURL();
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        "name": nameController.text.trim(),
                                        "emailId": emailController.text.trim(),
                                        "bio": bioController.text.trim(),
                                        "imageUrl": imageUrl,
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(_scaffoldKey.currentContext!)
                                          .pop();
                                    } on FirebaseAuthException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text(e.message.toString())));
                                    }
                                  }
                                },
                              ))
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(27, 88, 231, 1),
                                ),
                              ),
                      ],
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ));
  }
}
