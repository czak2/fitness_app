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
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String imageUrl = "";
  User? userId = FirebaseAuth.instance.currentUser;
  static final notification = NotificationServices();
  File? image;
  final picker = ImagePicker();
  bool isLoading = false;

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  Future<void> requestPermission(
      Permission permission, ImageSource source) async {
    PermissionStatus status = await permission.request();
    if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Access granted")));
      getImage(source);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Access denied")));
    }
    Navigator.pop(context);
  }

  void showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(),
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () =>
                      requestPermission(Permission.camera, ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () => requestPermission(
                      Permission.storage, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserProfile(
      String name, String emailId, String bio, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection("user").doc(userId!.uid).set({
        "name": name,
        "emailId": emailId,
        "bio": bio,
        "createdAt": DateTime.now(),
        "userId": userId!.uid,
        "imageUrl": imageUrl,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('updateComplete', true);
      await notification.requestPermission();
      await notification.getToken();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(imgUrl: imageUrl)));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> handleUpdateProfile() async {
    setState(() {
      isLoading = true;
    });
    String name = nameController.text.trim();
    String emailId = emailController.text.trim();
    String bio = bioController.text.trim();
    if (name.isNotEmpty && emailId.isNotEmpty && bio.isNotEmpty) {
      if (image != null) {
        String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceImageToUpload =
            referenceRoot.child("images/$uniqueId");
        await referenceImageToUpload.putFile(File(image!.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      }
      updateUserProfile(name, emailId, bio, imageUrl);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter required fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            image: AssetImage(images1[0]),
            fit: BoxFit.cover,
          ),
        ),
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("An error occurred"));
              }
              if (snapshot.data!.docs.isEmpty) {
                return buildProfileForm(context);
              } else {
                return buildExistingProfileForm(context, snapshot);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProfileForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "UPDATE PROFILE",
            style: GoogleFonts.oswald(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          InkWell(
            onTap: showImagePickerDialog,
            child: buildImagePicker(),
          ),
          SizedBox(height: 20),
          buildTextFormField(nameController, "Full name", Icons.person),
          SizedBox(height: 20),
          buildTextFormField(emailController, "EmailId", Icons.email,
              TextInputType.emailAddress),
          SizedBox(height: 20),
          buildTextFormField(
              bioController, "Bio", Icons.note_alt, TextInputType.multiline, 3),
          SizedBox(height: 15),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Color.fromRGBO(27, 88, 231, 1)))
              : CustomButon(title: "NEXT", onPressed: handleUpdateProfile),
        ],
      ),
    );
  }

  Widget buildExistingProfileForm(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    var doc = snapshot.data!.docs[0];
    nameController.text = doc["name"];
    emailController.text = doc["emailId"];
    bioController.text = doc["bio"];
    imageUrl = doc["imageUrl"];
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        Text("UPDATE PROFILE",
            style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        InkWell(
          onTap: showImagePickerDialog,
          child: buildImagePicker(),
        ),
        SizedBox(height: 20),
        buildTextFormField(nameController, "Full name", Icons.person),
        SizedBox(height: 20),
        buildTextFormField(emailController, "EmailId", Icons.email,
            TextInputType.emailAddress),
        SizedBox(height: 20),
        buildTextFormField(
            bioController, "Bio", Icons.note_alt, TextInputType.multiline, 3),
        SizedBox(height: 15),
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(27, 88, 231, 1)))
            : CustomButon(title: "UPDATE", onPressed: handleUpdateProfile),
      ],
    );
  }

  Widget buildImagePicker() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 136,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: image != null
                        ? FileImage(image!)
                        : imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : AssetImage("assets/images/settingprofile.png")
                                as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 80,
                bottom: 10,
                child:
                    Icon(Icons.camera_enhance, size: 40, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(
      TextEditingController controller, String hintText, IconData icon,
      [TextInputType inputType = TextInputType.text, int maxLines = 1]) {
    return SizedBox(
      height: maxLines == 1 ? 80 : null,
      child: TextFormField(
        maxLength: 50,
        style: GoogleFonts.oswald(),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          hintStyle: GoogleFonts.oswald(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(27, 88, 231, 1)),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.blue)),
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.blue),
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
