import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEFBF2),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/splash.png',
                width: 200.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
                width: 25.0,
                height: 25.0,
              )
            ],
          ),
        ));
  }
}
