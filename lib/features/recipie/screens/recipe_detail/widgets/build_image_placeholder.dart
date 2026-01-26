import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildImagePlaceholder() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Get.theme.colorScheme.primary.withOpacity(0.3),
          Get.theme.colorScheme.secondary.withOpacity(0.3),
        ],
      ),
    ),
    child: const Center(
      child: Icon(
        Icons.restaurant_menu,
        size: 80,
        color: Colors.white,
      ),
    ),
  );
}
