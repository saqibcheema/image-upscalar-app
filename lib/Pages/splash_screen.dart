import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Delay 3 seconds then navigate
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF7F4EA),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 120),
            Text.rich(
              TextSpan(
                text: 'AI',
                style: TextStyle(
                  fontFamily: 'Dareo',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '\nImage UpScalar',
                    style: TextStyle(
                      fontFamily: 'Dareo',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Lottie.asset('assets/lottie/onb4.json'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
