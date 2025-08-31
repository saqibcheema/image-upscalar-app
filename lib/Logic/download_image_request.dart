import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../Widgets/SnackBarWidget.dart';
import 'image_enhancer_provider.dart';


class DownloadEnhancedImage {
  Future<bool> requestPermission()async{
    if(Platform.isAndroid){
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if(deviceInfo.version.sdkInt >= 33){
        final status = await Permission.photos.request();
        return status.isGranted;
      }else{
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true;
  }

  Future<void> downloadEnhancedImage(BuildContext context)async{
    final provider = Provider.of<ImagePickerProvider>(context, listen: false);
    try{
      final status = await requestPermission();
      if(!status){
        return;
      }
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Step 2: Stream download to temp file
      await Dio().download(provider.enhancedImageUrl!, tempPath);

      // Step 3: Save file to gallery
      final result = await ImageGallerySaverPlus.saveFile(tempPath);

      print("✅ Image saved: $result");

      // Step 4 (optional): temp file delete kardo to free space
      final file = File(tempPath);
      if (await file.exists()) {
        await file.delete();
      }
      showSnackBar('Image saved to gallery');

    }catch(e){
      print(e);
      showSnackBar('Failed to save image: $e');
    }
  }
}