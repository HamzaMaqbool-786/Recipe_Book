import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../data/models/recipe.dart';
import 'build_image_placeholder.dart';

Widget buildImage(Recipe recipe) {
  Widget child;

  if (recipe.imagePath == null) {
    child = buildImagePlaceholder();
  } else if (recipe.imagePath!.startsWith('http')) {
    // Network image
    child = Image.network(
      recipe.imagePath!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildImagePlaceholder(),
    );
  } else if (recipe.imagePath!.startsWith('assets/')) {
    // Asset image
    child = Image.asset(
      recipe.imagePath!,
      fit: BoxFit.cover,
    );
  } else {
    // File image (from mobile)
    child = Image.file(
      File(recipe.imagePath!),
      fit: BoxFit.cover,
    );
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[200],
      child: child,
    ),
  );
}