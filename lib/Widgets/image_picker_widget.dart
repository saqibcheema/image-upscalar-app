import 'package:flutter/material.dart';
import 'package:image_enhancer/Widgets/SnackBarWidget.dart';
import 'package:provider/provider.dart';
import '../Logic/image_enhancer_provider.dart';


class ImagePickedContainer extends StatelessWidget {
  const ImagePickedContainer({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImagePickerProvider>(context,listen: false);
    return GestureDetector(
      onTap: ()async{
        try{
        final success = await provider.imagePicker(context);

        if(success){
          provider.sendImageToApi();
      }}catch(e){
         showSnackBar( e.toString());
        }
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xffF7F4EA),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 5),
                  spreadRadius: 2
                )
              ]
            ),
          ),
          Positioned(
            top: 10,
            left: 40,
            child: CustomPaint(
              painter: DotedBorderContainer(),
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                  child: Text('Click and Drag to upload Image',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class DotedBorderContainer extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style  = PaintingStyle.stroke
      ..color =  Colors.grey.shade800
      ..strokeWidth = 2;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(10),
        ),
      );
    // Draw dashes
    final dashesWidth = 5;
    final dashSpaces = 3;

    for(final metrics in path.computeMetrics()) {
      double start = 0.0;
      while(start < metrics.length){
        final end = start + dashesWidth;
        canvas.drawPath(metrics.extractPath(start, end), paint);
        start += dashesWidth + dashSpaces;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

