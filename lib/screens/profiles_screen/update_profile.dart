import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/chat/notification_service.dart';

import 'package:fitness_app/screens/home_screens/home_first.dart';
import 'package:fitness_app/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../chat/firebase_provider.dart';
import '../../constants/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String imageUrl = "";
  late User? userId = FirebaseAuth.instance.currentUser;
  static final notification = NotificationServices();
  File? image;
  final picker = ImagePicker();
  bool isLoading = false;
  Future getImageGall() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
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

  Future permissionGallery() async {
    PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Access granted"),
      ));
      getImageGall();
      Navigator.pop(context);
    }
    if (status == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Access denied"),
      ));
      Navigator.pop(context);
    }
    if (status == PermissionStatus.permanentlyDenied) {
      Navigator.pop(context);
    }
  }

  Future permissionCamera() async {
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Access granted"),
      ));
      getImageCam();
      Navigator.pop(context);
    }
    if (status == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Access denied"),
      ));
      Navigator.pop(context);
    }
    if (status == PermissionStatus.permanentlyDenied) {
      Navigator.pop(context);
    }
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(),
          content: Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    permissionCamera();
                  },
                  child: ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    permissionGallery();
                  },
                  child: ListTile(
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
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: AssetImage(images1[0]),
                fit: BoxFit.cover)),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .where("userId", isEqualTo: userId!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "UPDATE PROFILE",
                          style: GoogleFonts.oswald(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            dialog(context);
                          },
                          child: Center(
                            child: Container(
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
                                                    BorderRadius.circular(25),
                                                image: DecorationImage(
                                                    image: FileImage(image!),
                                                    fit: BoxFit.cover)),
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            height: 136,
                                            width: 140,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/settingprofile.png",
                                                    ),
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            maxLength: 50,
                            //controller: phoneController,
                            controller: nameController,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "Full name",
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
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            maxLength: 50,
                            //controller: phoneController,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 88, 231, 1)),
                                counterText: "",
                                hintText: "EmailId",
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
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                          child: TextFormField(
                            maxLines: 20,
                            //expands: true,
                            //controller: phoneController,
                            controller: bioController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 88, 231, 1)),
                                counterText: "",
                                hintText: "Bio",
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
                        SizedBox(
                          height: 15,
                        ),
                        isLoading == false
                            ? Center(
                                child: CustomButon(
                                    title: "NEXT",
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String uniquie = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      Reference referenceRoot =
                                          FirebaseStorage.instance.ref();
                                      Reference referenceImage =
                                          referenceRoot.child("images");
                                      Reference referenceImageToUpload =
                                          referenceImage.child(uniquie);
                                      var name = nameController.text.trim();
                                      var bio = bioController.text.trim();
                                      var emailId = emailController.text.trim();
                                      if (name.isNotEmpty &&
                                          emailId.isNotEmpty &&
                                          bio.isNotEmpty &&
                                          image != null) {
                                        try {
                                          await referenceImageToUpload
                                              .putFile(File(image!.path));
                                          imageUrl =
                                              await referenceImageToUpload
                                                  .getDownloadURL();
                                          await FirebaseFirestore.instance
                                              .collection("user")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({
                                            "name": name,
                                            "emailId": emailId,
                                            "bio": bio,
                                            "createdAt": DateTime.now(),
                                            "userId": userId!.uid,
                                            "imageUrl": imageUrl
                                          });
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.setBool('updateComplete', true);
                                          await notification
                                              .requestPermission();
                                          await notification.getToken();
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                          imgUrl: imageUrl)));
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please enter required field")));
                                      }
                                    }),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(27, 88, 231, 1),
                                ),
                              )
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
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
                      TextEditingController bioController =
                          TextEditingController(
                              text: snapshot.data!.docs[index]["bio"]);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("UPDATE PROFILE",
                              style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              dialog(context);
                            },
                            child: Center(
                              child: Container(
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
                                                      BorderRadius.circular(25),
                                                  image: DecorationImage(
                                                      image: FileImage(image!),
                                                      fit: BoxFit.cover)),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              height: 136,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrl),
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
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              maxLength: 50,
                              style: GoogleFonts.oswald(),
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
                                  labelStyle:
                                      const TextStyle(color: Colors.blue),
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              maxLength: 50,
                              style: GoogleFonts.oswald(),
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
                                  labelStyle:
                                      const TextStyle(color: Colors.blue),
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
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
                                  labelStyle:
                                      const TextStyle(color: Colors.blue),
                                  prefixIcon: const Icon(Icons.note_alt),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
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
                                          "emailId":
                                              emailController.text.trim(),
                                          "bio": bioController.text.trim(),
                                        });
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setBool('updateComplete', true);
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Navigator.popUntil(
                                            _scaffoldKey.currentContext!,
                                            (route) => route.isFirst);
                                        Navigator.pushReplacement(
                                            _scaffoldKey.currentContext!,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                        imgUrl: imageUrl)));
                                      } on FirebaseAuthException catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    e.message.toString())));
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
                                          "emailId":
                                              emailController.text.trim(),
                                          "bio": bioController.text.trim(),
                                          "imageUrl": imageUrl,
                                        });
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setBool('updateComplete', true);
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Navigator.popUntil(
                                            _scaffoldKey.currentContext!,
                                            (route) => route.isFirst);
                                        Navigator.pushReplacement(
                                            _scaffoldKey.currentContext!,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                        imgUrl: imageUrl)));
                                      } on FirebaseAuthException catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    e.message.toString())));
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
          ),
        ),
      ),
    );
  }
}
