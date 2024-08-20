// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fitness_app/chat/notification_service.dart';
// import 'package:fitness_app/screens/profiles_screen/update_profile.dart';
// import 'package:fitness_app/screens/authen_screen/phone_num_auth.dart';
// import 'package:fitness_app/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';

// class OtpScreen2 extends StatefulWidget {
//   final phoneNumber;
//   const OtpScreen2({super.key, required this.phoneNumber});

//   @override
//   State<OtpScreen2> createState() => _OtpScreen2State();
// }

// class _OtpScreen2State extends State<OtpScreen2> {
//   bool isLoading = false;
//   TextEditingController otpController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   static final notification = NotificationServices();
//   String code = "";
//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//         fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: Colors.lightBlue,
//       ),
//     ),
//   );
//   final focusedPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//         fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: Colors.lightBlue,
//       ),
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
//                 image: AssetImage("assets/images/onboard1.png"),
//                 fit: BoxFit.cover)),
//         child: Container(
//           margin: EdgeInsets.only(left: 10, right: 10),
//           child: Column(children: [
//             Spacer(
//               flex: 1,
//             ),
//             Text(
//               "VERIFICATION",
//               style: GoogleFonts.oswald(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 32,
//                   color: const Color.fromRGBO(27, 88, 231, 1)),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Text(
//                 "We have sent the verification code to your Mobile Number",
//                 style: GoogleFonts.oswald(
//                     fontSize: 17, color: Colors.white.withOpacity(0.80)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(widget.phoneNumber,
//                 style: GoogleFonts.oswald(
//                     fontSize: 17,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(
//               height: 10,
//             ),
//             Pinput(
//               controller: otpController,
//               length: 6,

//               // focusedPinTheme: focusedPinTheme,
//               // defaultPinTheme: defaultPinTheme,
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             // isLoading == false
//             //     ? ElevatedButton(
//             //         style: ElevatedButton.styleFrom(
//             //             shape: BeveledRectangleBorder(),
//             //             minimumSize: Size(120, 70),
//             //             backgroundColor: Colors.blue),
//             //         onPressed: () async {
//             //           setState(() {
//             //             isLoading = true;
//             //           });
//             //           try {
//             //             PhoneAuthCredential authCredential =
//             //                 PhoneAuthProvider.credential(
//             //                     verificationId: VerifyPhone.verify,
//             //                     smsCode: otpController.text);
//             //             await _auth.signInWithCredential(authCredential);
//             //             Navigator.pushReplacement(
//             //                 context,
//             //                 MaterialPageRoute(
//             //                   builder: (context) => UpdateProfileScreen(),
//             //                 ));
//             //             setState(() {
//             //               isLoading = false;
//             //             });
//             //           } on FirebaseAuthException catch (e) {
//             //             setState(() {
//             //               isLoading = false;
//             //             });
//             //             print(e.message);
//             //             ScaffoldMessenger.of(context).showSnackBar(
//             //                 const SnackBar(content: Text("Enter Valid Otp")));
//             //           }
//             //         },
//             //         child: const Text("SUBMIT",
//             //             style: TextStyle(
//             //                 fontSize: 18,
//             //                 color: Colors.white,
//             //                 fontWeight: FontWeight.bold)))
//             //     : CircularProgressIndicator(),
//             // TextButton.icon(
//             //     onPressed: () {},
//             //     icon: Icon(Icons.replay_outlined),
//             //     label: Text(
//             //       "RESEND CODE",
//             //       style: GoogleFonts.lato(color: Colors.grey),
//             //     )),
//             isLoading == false
//                 ? CustomButon(
//                     title: "SUBMIT",
//                     onPressed: () async {
//                       setState(() {
//                         isLoading = true;
//                       });
//                       try {
//                         PhoneAuthCredential authCredential =
//                             PhoneAuthProvider.credential(
//                                 verificationId: VerifyPhone.verify,
//                                 smsCode: otpController.text);
//                         await _auth.signInWithCredential(authCredential);
//                         await notification.requestPermission();
//                         await notification.getToken();
//                         await Future.delayed(Duration(seconds: 4));
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateProfileScreen(),
//                             ));
//                         setState(() {
//                           isLoading = false;
//                         });
//                       } on FirebaseAuthException catch (e) {
//                         setState(() {
//                           isLoading = false;
//                         });
//                         print(e.message);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Enter Valid Otp")));
//                       }
//                     })
//                 : CircularProgressIndicator(
//                     color: Color.fromRGBO(27, 88, 231, 1),
//                   ),
//             Spacer()
//           ]),
//         ),
//       ),
//     );
//   }
// }
