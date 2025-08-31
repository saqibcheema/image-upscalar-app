import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: onBoardingPages,
        enableLoop: false,
        initialPage: 0,
        slideIconWidget: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: lastPage
              ? SizedBox()
              : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
        ),
        onPageChangeCallback: (index) async {
          if (index == onBoardingPages.length - 1) {
            setState(() {
              lastPage = true;
            });
            await Future.delayed(Duration(seconds: 5));
            if (!context.mounted) return;
            Navigator.push(context, createTransition(HomePage(), false));
          }
        },
      ),
    );
  }
}

PageRouteBuilder<dynamic> createTransition(Widget page, bool backward) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = backward ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

final onBoardingPages = [
  Container(
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
  Container(
    color: Color(0xffE5BEB5),
    height: double.infinity,
    width: double.infinity,
    child: Column(
      children: [
        SizedBox(height: 100),
        Text(
          'One Tap magic',
          style: TextStyle(
            fontFamily: 'Dareo',
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        Text.rich(
          TextSpan(
            text: 'No editing skills needed. Just ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '\nupload',
                style: TextStyle(
                  fontFamily: 'Dareo',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'upscale',
                style: TextStyle(
                  fontFamily: 'Dareo',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(text: ' in Seconds '),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Lottie.asset('assets/lottie/onb6.json', height: 300),
        SizedBox(height: 20),
      ],
    ),
  ),
];