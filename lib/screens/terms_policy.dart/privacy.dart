import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/onboard2.png'), // Ensure you have this image in your assets folder
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
                    'PRIVACY POLICY',
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
                            'INFORMATION COLLECTION:',
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
                            '1.1 We may collect personal information, such as your name, address, email address, phone number, and emergency contact details when you sign up for a membership.\n\n'
                            '1.2 We may also collect health-related information, including medical conditions or injuries, to ensure your safety and provide appropriate guidance during your workouts.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'USE OF INFORMATION:',
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
                            '2.1 We will use your personal information to:\n'
                            'a) Manage and maintain your gym membership account.\n'
                            'b) Provide you with access to our facilities, equipment, and services.\n'
                            'c) Communicate with you regarding membership-related updates, promotions, and events.\n'
                            'd) Improve our services and customize your gym experience.\n\n'
                            '2.2 We may also use your de-identified and aggregated data for statistical analysis and research purposes.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'INFORMATION DISCLOSURE:',
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
                            '3.1 We will not sell, rent, or lease your personal information to third parties unless we have obtained your consent or are required by law to do so.\n\n'
                            '3.2 We may share your information with select service providers who assist us in operating our facilities and providing our services.',
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
