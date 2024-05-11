import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.white.withOpacity(0.4),
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }
}
