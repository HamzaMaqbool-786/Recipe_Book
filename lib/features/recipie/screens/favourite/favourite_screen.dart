import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/common/widgets/recipe_card.dart';
import '../../controllers/recipe_controller.dart';

import '../recipe_detail/recipe_detail_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find<RecipeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Obx(() {
        final favorites = controller.favoriteRecipes;

        if (favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorite recipes yet!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add some recipes to favorites to see them here.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final recipe = favorites[index];
            return RecipeCard(
              recipe: recipe,
              onTap: () {
                Get.to(() => RecipeDetailScreen(recipe: recipe));
              },
            );
          },
        );
      }),
    );
  }
}
