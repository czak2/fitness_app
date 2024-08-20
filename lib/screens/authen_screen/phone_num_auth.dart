import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fitness_app/widgets/custom_button.dart';

import '../../provider/verify.dart';
import '../terms_policy.dart/privacy.dart';
import '../terms_policy.dart/term.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyPhoneProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              image: AssetImage("assets/images/onboard1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Consumer<VerifyPhoneProvider>(
                builder: (context, provider, child) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;

                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        SvgPicture.asset("assets/images/logo.svg",
                            width: screenWidth * 0.5),
                        SizedBox(height: screenHeight * 0.06),
                        Text(
                          "WELCOME\nBACK",
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: screenWidth * 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Sign In to your account",
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    onSelect: (country) {
                                      provider.updateSelectedCountry(country);
                                    },
                                  );
                                },
                                child: Text(
                                  "${provider.selectedCountry.flagEmoji} +${provider.selectedCountry.phoneCode}",
                                  style: GoogleFonts.oswald(
                                    color: Color.fromRGBO(27, 88, 231, 1),
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: TextField(
                                  maxLength: 10,
                                  controller: provider.phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: GoogleFonts.oswald(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: GoogleFonts.oswald(
                                      color: Color.fromRGBO(27, 88, 231, 1),
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          children: [
                            Checkbox(
                              value: provider.isChecked,
                              onChanged: (value) {
                                provider.toggleChecked();
                              },
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'I accept all ',
                                  style: GoogleFonts.oswald(
                                    color: Colors.white.withOpacity(0.70),
                                    fontSize: screenWidth * 0.03,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TermsPage()),
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: GoogleFonts.oswald(
                                        color: Colors.white.withOpacity(0.70),
                                        fontSize: screenWidth * 0.03,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrivacyPolicyPage()),
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: ' by pressing the continue button.',
                                      style: GoogleFonts.oswald(
                                        color: Colors.white.withOpacity(0.70),
                                        fontSize: screenWidth * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        if (provider.isLoading)
                          Center(child: CircularProgressIndicator())
                        else
                          CustomButon(
                            title: "NEXT",
                            onPressed: () {
                              String phoneNumber =
                                  provider.phoneController.text.trim();
                              if (phoneNumber.isNotEmpty &&
                                  provider.isChecked) {
                                String fullPhoneNumber =
                                    "+${provider.selectedCountry.phoneCode}$phoneNumber";
                                provider.resendOTP(context, fullPhoneNumber);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Please enter your phone number and accept the terms"),
                                  ),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
