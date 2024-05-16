import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/screens/authen_screen/otp_verification.dart';
import 'package:fitness_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});
  static String verify = "";

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "example",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: AssetImage("assets/images/onboard1.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                SvgPicture.asset(
                  "assets/images/logo.svg",
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "WELCOME\nBACK",
                  style: GoogleFonts.oswald(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 46,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Enter your phone number to continue",
                  style: GoogleFonts.oswald(
                      color: Colors.white.withOpacity(0.70),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    style: GoogleFonts.oswald(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    controller: phoneController,
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: "Phone Number",
                        // label: const Text(
                        //   "Phone number",
                        //   style: TextStyle(fontSize: 15),
                        // ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.blue)),
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.blue),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 500),
                                context: context,
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                              );
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: isLoading == false
                      ? CustomButon(
                          title: "NEXT",
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            String phoneNumber =
                                "+${selectedCountry.phoneCode}${phoneController.text}";
                            if (phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please enter phone number")));
                              setState(() {
                                isLoading = false;
                              });
                            } else if (phoneController.text.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please enter a valid phone number")));
                              setState(() {
                                isLoading = false;
                              });
                            }
                            try {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: phoneNumber,
                                verificationCompleted: (phoneAuthCredential) {},
                                verificationFailed: (error) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(error.message.toString())));
                                },
                                codeSent:
                                    (verificationId, forceResendingToken) {
                                  VerifyPhone.verify = verificationId;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtpScreen2(
                                            phoneNumber: phoneNumber),
                                      ));
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                codeAutoRetrievalTimeout: (verificationId) {},
                              );
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              print(e.message);
                            }
                          })
                      : CircularProgressIndicator(
                          color: Color.fromRGBO(27, 88, 231, 1),
                        ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
