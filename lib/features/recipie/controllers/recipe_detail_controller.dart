import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/models/recipe.dart';
import '../../../utils/popups/loader.dart';

import 'recipe_controller.dart';

class RecipeDetailController extends GetxController {
  var recipe = Rx<Recipe?>(null);
  var checkedIngredients = <bool>[].obs;

  void initRecipe(Recipe initialRecipe) {
    recipe.value = initialRecipe;
    checkedIngredients.value = List.generate(
      initialRecipe.ingredients.length,
          (_) => false,
    );
  }

  void toggleIngredient(int index) {
    checkedIngredients[index] = !checkedIngredients[index];
  }

  Future<void> toggleFavorite() async {
    if (recipe.value == null) return;

    final recipeController = Get.find<RecipeController>();
    await recipeController.toggleFavorite(recipe.value!.id);

    // Update local recipe object
    recipe.value = recipeController.getRecipeById(recipe.value!.id);
  }

  void shareRecipe() {
    if (recipe.value == null) return;

    final recipeText = '''
${recipe.value!.name}

${recipe.value!.description}

Cooking Time: ${recipe.value!.cookingTime} minutes
Difficulty: ${recipe.value!.difficulty}
Servings: ${recipe.value!.servings}

INGREDIENTS:
${recipe.value!.ingredients.map((i) => '• $i').join('\n')}

INSTRUCTIONS:
${recipe.value!.instructions.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}
''';

    Clipboard.setData(ClipboardData(text: recipeText));
    TLoaders.successSnackBar(
      title: 'Copied',
      message: 'Recipe copied to clipboard!',
      duration: 2,
    );
  }

  Future<void> deleteRecipe() async {
    if (recipe.value == null) return;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text('Are you sure you want to delete "${recipe.value!.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final recipeController = Get.find<RecipeController>();
      await recipeController.deleteRecipe(recipe.value!.id);
      TLoaders.successSnackBar(
        title: 'Deleted',
        message: 'Recipe deleted successfully!',
      );
    }
  }
}
