import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipie/screens/recipe_detail/widgets/build_image.dart';
import 'package:recipe_book/features/recipie/screens/recipe_detail/widgets/description.dart';
import 'package:recipe_book/features/recipie/screens/recipe_detail/widgets/info_bar.dart';
import 'package:recipe_book/features/recipie/screens/recipe_detail/widgets/ingredients.dart';
import 'package:recipe_book/features/recipie/screens/recipe_detail/widgets/instructions.dart';

import '../../../../data/models/recipe.dart';
import '../../controllers/recipe_controller.dart';
import '../../controllers/recipe_detail_controller.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeDetailController());
    final recipeController = Get.find<RecipeController>();
    controller.initRecipe(recipe);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          Obx(() {
            // Check if the recipe still exists
            final currentRecipe = recipeController.recipes
                .firstWhereOrNull((r) => r.id == recipe.id);

            // If deleted, automatically go back
            if (currentRecipe == null) {
              Future.microtask(() => Get.back());
              return Container(); // empty widget
            }

            // Favorite button
            return IconButton(
              icon: Icon(
                currentRecipe.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: currentRecipe.isFavorite ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                recipeController.toggleFavorite(recipe.id);
              },
            );
          }),

          // Popup menu
          Obx(() {
            final currentRecipe = recipeController.recipes
                .firstWhereOrNull((r) => r.id == recipe.id);

            if (currentRecipe == null) return Container();

            return PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'share') {
                  controller.shareRecipe();
                } else if (value == 'delete') {
                  controller.deleteRecipe();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share, size: 20),
                      SizedBox(width: 10),
                      Text('Share'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Hero(tag: recipe.id, child: buildImage(recipe)),

            // Quick Info Bar
            buildInfoBar(recipe, context),

            const Divider(height: 1),

            // Description
            if (recipe.description.isNotEmpty) buildDescription(recipe),

            const Divider(height: 1),

            // Ingredients
            buildIngredients(recipe, controller),

            const Divider(height: 1),

            // Instructions
            buildInstructions(recipe, context),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
