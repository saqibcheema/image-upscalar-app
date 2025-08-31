import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../Utils/utilities.dart';
import '../Widgets/SnackBarWidget.dart';

class ImagePickerProvider extends ChangeNotifier {
  bool _isImageSelected = false;
  bool get isImageSelected => _isImageSelected;

  var header = {'x-api-key': Utilities().ApiKey};

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  String? _taskId; // Changed to nullable String
  String? get taskId => _taskId;

  // Enhanced Image Url - initialize as nullable
  String? enhancedImageUrl;
  bool isEnhancedImageLoading = false; // Start with false


  Future<bool> imagePicker(BuildContext context) async {
    try {
      final imagePicked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imagePicked != null) {
        _selectedImage = File(imagePicked.path);
        _isImageSelected = true;
        // Reset enhanced image when new image is selected
        enhancedImageUrl = null;
        _taskId = null;
        notifyListeners();
      }
    } catch (e) {
      showSnackBar(e.toString());
    }
    return _isImageSelected;
  }

  Future<void> sendImageToApi() async {
    if (_selectedImage == null) {
      showSnackBar('Please Select an Image');
      return;
    }

    try {
      isEnhancedImageLoading = true;
      enhancedImageUrl = null;
      notifyListeners();

      var url = Uri.parse(Utilities().baseUrl);
      var request = http.MultipartRequest('POST', url);
      request.fields['scale'] = '4';
      request.files.add(
        await http.MultipartFile.fromPath('image_file', _selectedImage!.path),
      );
      request.headers.addAll(header);

      final response = await request.send().timeout(Duration(seconds: 30));
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseString);

        // CORRECTED: task_id is inside the 'data' object
        if (responseJson['data'] != null && responseJson['data']['task_id'] != null) {
          final taskId = responseJson['data']['task_id'].toString();

          _taskId = taskId;
          notifyListeners();
          await getEnhancedImage();
        } else {
          throw Exception('No task_id in response data: $responseString');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: $responseString');
      }

    } catch (e) {
      showSnackBar('Failed to send image to API: ${e.toString()}');
    } finally {
      isEnhancedImageLoading = false;
      notifyListeners();
    }
  }

  Future<void> getEnhancedImage() async {
    if (_taskId == null || _taskId!.isEmpty) return;

    try {
      isEnhancedImageLoading = true;
      notifyListeners();

      // Maximum number of retries
      const int maxRetries = 30; // 30 attempts (about 60 seconds)
      int attempt = 0;
      bool imageReady = false;

      while (attempt < maxRetries && !imageReady) {
        attempt++;

        var response = await http.get(
            Uri.parse('${Utilities().baseUrl}/$_taskId'),
            headers: {'x-api-key': Utilities().ApiKey}
        ).timeout(Duration(seconds: 30));


        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);

          // Check different possible response structures
          if (jsonResponse['data'] != null && jsonResponse['data']['image'] != null) {
            // Image is ready!
            enhancedImageUrl = jsonResponse['data']['image'];
            imageReady = true;
          }
          else if (jsonResponse['status'] == 'processing' ||
              jsonResponse['status'] == 'pending') {
            await Future.delayed(Duration(seconds: 2)); // Wait 2 seconds
            continue;
          }
          else if (jsonResponse['data'] != null && jsonResponse['data']['status'] == 'processing') {
            await Future.delayed(Duration(seconds: 2));
            continue;
          }
          else {
            await Future.delayed(Duration(seconds: 2));
            continue;
          }
        }
        else if (response.statusCode == 202) {
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
        else {
          // Error response
          throw Exception('HTTP ${response.statusCode}: ${response.body}');
        }
      }

      if (!imageReady) {
        throw Exception('Image processing timed out after $maxRetries attempts');
      }

    } catch (e) {
      showSnackBar('Failed to get enhanced image: ${e.toString()}');
    } finally {
      isEnhancedImageLoading = false;
      notifyListeners();
    }
  }


}