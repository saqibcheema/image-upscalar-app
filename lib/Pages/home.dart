import 'dart:ui';
import 'package:flutter/material.dart';

import 'main_page.dart';
import 'onboarding_sreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _blurWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: Container(
        color: Color(0xffF6F1E9),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Image Upscale',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Dareo',
                ),
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _blurWidth += details.delta.dx;
                  if (_blurWidth < 0) _blurWidth = 0;
                  if (_blurWidth > containerWidth) {
                    _blurWidth = containerWidth;
                  }
                });
              },
              onTap: (){
                Navigator.push(context, createTransition(IndexScreen(), false));
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/upscaleImage.avif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: _blurWidth,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: _blurWidth - 1,
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 300,
                          width: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_blurWidth > 40)
                      Positioned(
                        left: _blurWidth - 40,
                        top: 150, // Center vertically
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black87,
                            size: 16,
                          ),
                        ),
                      ),
                    // Right arrow (forward) - only show if there's space
                    if (_blurWidth < containerWidth - 40)
                      Positioned(
                        left: _blurWidth + 10,
                        top: 150, // Center vertically
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black87,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
