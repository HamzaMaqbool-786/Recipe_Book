import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/utils/helper/helper_functions.dart';
import '../../../data/models/recipe.dart';
import '../../../features/recipie/controllers/recipe_controller.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find<RecipeController>();

    return Hero(
      tag: recipe.id,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        final Hero toHero = toHeroContext.widget as Hero;
        return ScaleTransition(
          scale: animation.drive(
            Tween(begin: 0.9, end: 1.0)
                .chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: toHero.child,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.orange.withOpacity(0.1),
          highlightColor: Colors.orange.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                _buildImage(recipe),

                const SizedBox(width: 14),

                /// INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Favorite
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              recipe.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /// Favorite button
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: Obx(() {
                              final currentRecipe = controller.recipes.firstWhere(
                                    (r) => r!.id == recipe.id,
                                orElse: () => recipe,
                              );

                              return IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  currentRecipe.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: currentRecipe.isFavorite
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () =>
                                    controller.toggleFavorite(recipe.id),
                              );
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Category
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HelperFunction.getCategoryColor(recipe.category)
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          recipe.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: HelperFunction.getCategoryColor(recipe.category)
                                .withOpacity(0.9),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Info Row
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          _infoIconText(
                            Icons.access_time,
                            '${recipe.cookingTime} min',
                            iconColor: Colors.orange.shade700,
                          ),
                          _infoIconText(Icons.person, recipe.difficulty,
                              iconColor: Colors.blue.shade700),
                          _infoIconText(
                            Icons.local_fire_department,
                            recipe.spiceLevel,
                            iconColor: HelperFunction.getSpiceColor(recipe.spiceLevel),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// Rating
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            if (index < recipe.rating.floor()) {
                              return const Icon(Icons.star, size: 16, color: Colors.amber);
                            } else if (index < recipe.rating) {
                              return const Icon(Icons.star_half, size: 16, color: Colors.amber);
                            } else {
                              return Icon(Icons.star_border, size: 16, color: Colors.grey[400]);
                            }
                          }),
                          const SizedBox(width: 6),
                          Text(
                            '(${recipe.rating.toStringAsFixed(1)})',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// IMAGE
  Widget _buildImage(Recipe recipe) {
    Widget image;

    if (recipe.imagePath == null) {
      image = _placeholder();
    } else if (recipe.imagePath!.startsWith('http')) {
      image = Image.network(
        recipe.imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else if (recipe.imagePath!.startsWith('assets/')) {
      image = Image.asset(recipe.imagePath!, fit: BoxFit.cover);
    } else {
      image = Image.file(File(recipe.imagePath!), fit: BoxFit.cover);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 90,
        height: 90,
        color: Colors.grey[200],
        child: image,
      ),
    );
  }

  Widget _placeholder() {
    return Icon(Icons.restaurant, size: 40, color: Colors.grey[400]);
  }

  Widget _infoIconText(IconData icon, String text, {Color? iconColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}
