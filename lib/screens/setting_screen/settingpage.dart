import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/user.dart';
import 'package:fitness_app/screens/profiles_screen/change_profile.dart';
import 'package:fitness_app/screens/terms_policy.dart/privacy.dart';
import 'package:fitness_app/screens/terms_policy.dart/term.dart';
import 'package:fitness_app/screens/workout_purchase_screen/payment_history.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../chat/firebase_provider.dart';
import '../../widgets/drawer.dart';
import '../notification_screen/notification_screen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    // final user = auth.currentUser;

    // TODO: implement initState
    super.initState();
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
            height: MediaQuery.of(context).size.height / 1.35,
            child: Drawer(
              child: DrawerWidget(),
              backgroundColor: const Color.fromARGB(255, 33, 86, 243),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          width: 86.81,
          height: 32.23,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotiScreen(),
                    ));
              },
              child: Icon(
                Icons.notifications_none,
                size: 25,
              ),
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(child: Consumer<FirebaseProvider>(
                builder: (context, value, child) {
                  return Container(
                    height: 136,
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        value.cUser!.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[700]!,
                            highlightColor: Colors.grey[500]!,
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.black,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                  );
                },
              )),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 32, 33, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeProfileScreen(),
                        ));
                  },
                  child: ListTile(
                      iconColor: Colors.white,
                      leading:
                          SvgPicture.asset("assets/icons/user-octagon.svg"),
                      title: Text(
                        "UPDATE PROFILE",
                        style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                      subtitle: Text(
                        "You can update your email,name,etc",
                        style: GoogleFonts.oswald(
                            color: Colors.white.withOpacity(0.55),
                            fontWeight: FontWeight.w300),
                      ),
                      trailing: Icon(Icons.arrow_forward)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 32, 33, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SubscriptionDialog();
                      },
                    );
                  },
                  child: ListTile(
                    iconColor: Colors.white,
                    leading: SvgPicture.asset("assets/icons/crown.svg"),
                    title: Text(
                      "MY SUBSCRIPTION",
                      style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      "Manage your subscription plan",
                      style: GoogleFonts.oswald(
                          color: Colors.white.withOpacity(0.55),
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 32, 33, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentHistory(),
                        ));
                  },
                  child: ListTile(
                    iconColor: Colors.white,
                    leading: SvgPicture.asset("assets/icons/receipt-item.svg"),
                    title: Text(
                      "PAYMENT HISTORY",
                      style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      "See your all transaction history",
                      style: GoogleFonts.oswald(
                          color: Colors.white.withOpacity(0.55),
                          fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 32, 33, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  iconColor: Colors.white,
                  leading: SvgPicture.asset("assets/icons/notification.svg"),
                  title: Text(
                    "NOTIFICATION",
                    style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                  subtitle: Text(
                    "Manage notification here",
                    style: GoogleFonts.oswald(
                        color: Colors.white.withOpacity(0.55),
                        fontWeight: FontWeight.w300),
                  ),
                  trailing: Switch(
                    focusColor: Color.fromRGBO(27, 88, 231, 1),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDeleteAccountDialog();
                        },
                      );
                    },
                    child: Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionDialog extends StatefulWidget {
  @override
  _SubscriptionDialogState createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 196, 54, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close, color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            Icon(Icons.diamond, size: 40, color: Colors.black),
            SizedBox(height: 10),
            Text(
              "SUBSCRIBE TO PREMIUM",
              style: GoogleFonts.oswald(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Monthly renewal: 16,99\$",
              style: GoogleFonts.oswald(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Premium content\nWorkout tutorial library\nChat support with\n(Nutritionist / Physiotherapist\nPersonal Trainer)",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.oswald(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: "I accept all "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Terms & Conditions screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsPage(),
                                ),
                              );
                            },
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Privacy Policy screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPolicyPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isChecked
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              child: Text(
                "SUBSCRIBE",
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDeleteAccountDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning,
                size: 80, color: Color.fromRGBO(27, 88, 231, 1)),
            SizedBox(height: 20),
            Text(
              "Are You Sure?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(27, 88, 231, 1),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Do you really want to delete this account? This process cannot be undone.",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(27, 88, 231, 1),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("CANCEL",
                      style: GoogleFonts.oswald(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(231, 27, 83, 1),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  onPressed: () {
                    // Implement delete account functionality here
                  },
                  child: Text("OK",
                      style: GoogleFonts.oswald(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
