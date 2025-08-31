import 'package:flutter/material.dart';
import 'package:image_enhancer/Widgets/original_image_widget.dart';
import 'package:image_enhancer/Widgets/image_picker_widget.dart';
import '../Widgets/enhanced_image_widget.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Image Upscale',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Dareo',
          ),
        ),
        backgroundColor: Color(0xffF6F1E9),
      ),
      backgroundColor: Color(0xffF6F1E9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagePickedContainer(),
                OriginalImageContainer(),
                EnhancedImageContainer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
