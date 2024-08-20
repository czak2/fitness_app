import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_picker/country_picker.dart';

import '../screens/profiles_screen/update_profile.dart';
import '../widgets/custom_button.dart';

class VerifyPhoneProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isChecked = false;
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
    e164Key: "",
  );
  String verificationId = "";

  bool get isLoading => _isLoading;
  bool get isChecked => _isChecked;

  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleChecked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  void updateSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  Future<void> verifyOTP(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Failed to verify OTP"),
        ),
      );
    }
  }

  Future<void> resendOTP(BuildContext context, String phoneNumber) async {
    setLoading(true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Failed to resend OTP"),
          ),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId = verificationId;
        setLoading(false);
        showVerificationDialog(context, phoneNumber);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  void showVerificationDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            setLoading(
                false); // Reset the loading state when the dialog is dismissed
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "VERIFICATION",
                      style: GoogleFonts.oswald(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "We have sent the verification code to your Mobile Number",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      phoneNumber,
                      style: GoogleFonts.oswald(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: otpFocusNodes[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    CustomButon(
                      title: "SUBMIT",
                      onPressed: () async {
                        String otp = otpControllers
                            .map((controller) => controller.text)
                            .join();
                        if (otp.length == 6) {
                          await verifyOTP(context, otp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Please enter a valid 6-digit OTP")),
                          );
                        }
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                        setLoading(
                            false); // Reset loading state before attempting to resend OTP
                        await resendOTP(context, phoneNumber);
                      },
                      child: Text(
                        "Resend Code",
                        style: GoogleFonts.oswald(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
