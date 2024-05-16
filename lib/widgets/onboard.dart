import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnBoardWidget({required this.subtitle, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 48,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1).withOpacity(0.75),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
