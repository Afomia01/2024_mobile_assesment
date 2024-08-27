import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // For the delay


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/grocery');
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'lib/assets/images/background.png',
            fit: BoxFit.cover,
          ),
          // Centered Texts
          Column(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns text to the bottom
            children: [
              Text(
                'welcome to',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 36 / 22,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8), // Gap between texts
              Text(
                'SPEEDY CHOW',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    height: 46.88 / 40,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50), // Space at the bottom
            ],
          ),
        ],
      ),
    );
  }
}
