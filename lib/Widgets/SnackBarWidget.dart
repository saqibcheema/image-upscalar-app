import 'package:flutter/material.dart';

import '../main.dart';


  void showSnackBar( String message) {
    final context = navigatorKey.currentContext!;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: message.contains('Failed') ? Colors.red : Colors.green,
      ),
    );
  }