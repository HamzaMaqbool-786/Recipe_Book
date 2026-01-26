import 'package:flutter/material.dart';

Widget buildNoResults() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 80,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Text(
          'No recipes found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Try searching for:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '• Recipe names',
          style: TextStyle(color: Colors.grey[500]),
        ),
        Text(
          '• Ingredients',
          style: TextStyle(color: Colors.grey[500]),
        ),
        Text(
          '• Categories',
          style: TextStyle(color: Colors.grey[500]),
        ),
      ],
    ),
  );
}
