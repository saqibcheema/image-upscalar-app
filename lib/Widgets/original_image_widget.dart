import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Logic/image_enhancer_provider.dart';
import '../Logic/download_image_request.dart';


class OriginalImageContainer extends StatelessWidget {
  const OriginalImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImagePickerProvider>(context) ;
    return Padding(
      padding: EdgeInsets.only(top : 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 280,
          width: 240,
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: Color(0xffB87C4C),
                child: Center(
                  child: Text(
                    'Original Image',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: provider.selectedImage != null
                    ? Image.file(provider.selectedImage!,fit: BoxFit.cover,)
                    : Center(child: Text('Please Select an Image',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
