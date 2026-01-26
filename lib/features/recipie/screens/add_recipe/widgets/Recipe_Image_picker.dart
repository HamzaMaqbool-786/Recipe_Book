import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controllers/add_recipe_controller.dart';

class RecipeImagePicker extends StatelessWidget {
  final AddRecipeController controller;
  const RecipeImagePicker({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: controller.pickImage,
        child: controller.imagePath.value != null
            ? Image.file(
          File(controller.imagePath.value!),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        )
            : Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.camera_alt, size: 50, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
