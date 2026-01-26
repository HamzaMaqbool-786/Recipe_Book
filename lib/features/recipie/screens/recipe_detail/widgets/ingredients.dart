import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../data/models/recipe.dart';
import '../../../controllers/recipe_detail_controller.dart';


Widget buildIngredients(Recipe recipe, RecipeDetailController controller) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.shopping_cart, size: 20),
            SizedBox(width: 8),
            Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(
          recipe.ingredients.length,
              (index) => Obx(() => CheckboxListTile(
            title: Text(
              recipe.ingredients[index],
              style: TextStyle(
                decoration: controller.checkedIngredients[index]
                    ? TextDecoration.lineThrough
                    : null,
                color: controller.checkedIngredients[index]
                    ? Colors.grey
                    : Colors.black87,
              ),
            ),
            value: controller.checkedIngredients[index],
            onChanged: (value) {
              controller.toggleIngredient(index);
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          )),
        ),
      ],
    ),
  );
}
