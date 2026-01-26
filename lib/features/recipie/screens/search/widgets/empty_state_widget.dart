import 'package:flutter/material.dart';

import '../../../controllers/search_controller.dart' as search;


Widget buildEmptyState(search.SearchController controller) {
  final popularSearches = ['Pasta', 'Chicken', 'Dessert', 'Salad'];

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search,
          size: 80,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Text(
          'Start typing to search',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Popular searches:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: popularSearches.map((search) {
            return ActionChip(
              label: Text(search),
              onPressed: () {
                controller.performSearch(search);
              },
            );
          }).toList(),
        ),
      ],
    ),
  );
}
