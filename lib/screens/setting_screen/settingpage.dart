import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/user.dart';
import 'package:fitness_app/screens/profiles_screen/change_profile.dart';
import 'package:fitness_app/screens/workout_purchase_screen/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
        title: SvgPicture.asset("assets/images/logo.svg"),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            image: NetworkImage(
                              value.cUser!.image,
                            ),
                            fit: BoxFit.cover)),
                  );
                },
              )),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade700,
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
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(15)),
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
                    "Manage your subsciption plan",
                    style: GoogleFonts.oswald(
                        color: Colors.white.withOpacity(0.55),
                        fontWeight: FontWeight.w300),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade700,
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
                    color: Colors.grey.shade700,
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
                    onPressed: () {},
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
