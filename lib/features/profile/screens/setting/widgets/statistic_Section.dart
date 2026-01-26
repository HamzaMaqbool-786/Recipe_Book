import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../recipie/controllers/recipe_controller.dart';

Widget buildStatisticsSection(RecipeController controller) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Statistics',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Obx(() => Row(
          children: [
            _statCard(
                Icons.restaurant, controller.recipeCount, 'Recipes'),
            _statCard(
                Icons.favorite, controller.favoriteCount, 'Favorites'),
          ],
        )),
      ],
    ),
  );

}
Widget _statCard(IconData icon, int value, String label) {
  return Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.orange),
            const SizedBox(height: 8),
            Text('$value',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label),
          ],
        ),
      ),
    ),
  );
}

