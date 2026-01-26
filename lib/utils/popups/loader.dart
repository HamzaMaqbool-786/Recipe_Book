import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TLoaders {
  /// Hide current snackbar
  static void hideSnackBar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }

  /// Custom Toast (Soft Dark – neutral for all screens)
  static void customToast({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black.withOpacity(0.85),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Success Snackbar (Green – Cooked / Completed)
  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50), // Green
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      shouldIconPulse: true,
      isDismissible: true,
      borderRadius: 12,
    );
  }

  /// Warning Snackbar (Orange – Food App Accent)
  static void warningSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFF9800), // Orange
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      shouldIconPulse: true,
      isDismissible: true,
      borderRadius: 12,
    );
  }

  /// Error Snackbar (Red – Something went wrong)
  static void errorSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE53935), // Red
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      icon: const Icon(Icons.error_outline, color: Colors.white),
      shouldIconPulse: true,
      isDismissible: true,
      borderRadius: 12,
    );
  }
}
