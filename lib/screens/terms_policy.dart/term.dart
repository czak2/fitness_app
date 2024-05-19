import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/onboard1.png'), // Ensure you have this image in your assets folder
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Handle back button press
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'TERMS & CONDITIONS',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'MEMBERSHIP AND ACCESS:',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '1.1 You must be at least 18 years of age or have the consent of a parent or guardian to become a member.\n\n'
                            '1.2 Your membership grants you access to our gym facilities during regular operating hours, subject to any additional restrictions or limitations communicated by the gym management.\n\n'
                            '1.3 Membership fees and any additional charges must be paid in accordance with the payment terms specified by the gym.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'CODE OF CONDUCT:',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '2.1 You are expected to behave in a respectful and responsible manner while using our gym facilities.\n\n'
                            '2.2 Any inappropriate or offensive behavior, harassment, or violation of gym rules may result in the termination of your membership without refund.\n\n'
                            '2.3 You are responsible for any damage caused to the gym\'s property or equipment due to negligence or misuse.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'HEALTH AND SAFETY:',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '3.1 You acknowledge that physical exercise can carry inherent risks, and it is your responsibility to assess your health condition and consult with a medical professional before using our gym facilities.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
