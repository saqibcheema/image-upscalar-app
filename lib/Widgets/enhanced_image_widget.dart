import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Logic/image_enhancer_provider.dart';
import '../Logic/download_image_request.dart';

class EnhancedImageContainer extends StatelessWidget {
  const EnhancedImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 280,
          width: 240,
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Column(
            children: [
              Consumer<ImagePickerProvider>(
                builder: (context, provider, child) => Stack(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Color(0xff386641),
                      child: Center(
                        child: Text(
                          'Enhanced Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<ImagePickerProvider>(
                builder: (context, provider, child) => Expanded(
                  child: Stack(
                    children: [
                      provider.isEnhancedImageLoading
                          ? Center(
                              child: Lottie.asset(
                                'assets/lottie/onb1.json',
                                fit: BoxFit.cover,
                              ), // Show loading indicator
                            )
                          : provider.enhancedImageUrl != null
                          ? Image.network(
                              provider.enhancedImageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: Lottie.asset(
                                        'assets/lottie/onb1.json',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error, color: Colors.red),
                                      SizedBox(height: 8),
                                      Text(
                                        'Failed to load image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'No enhanced image available',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),

                      if (provider.enhancedImageUrl != null)
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF6F1E9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  DownloadEnhancedImage().downloadEnhancedImage(
                                    context,
                                  );
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.black,
                                ),
                              ),
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
      ),
    );
  }
}
