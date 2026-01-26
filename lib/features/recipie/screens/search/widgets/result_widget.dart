import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../../utils/common/widgets/recipe_card.dart';

import '../../../controllers/search_controller.dart' as search;
import '../../recipe_detail/recipe_detail_screen.dart';
import 'no_result_widget.dart';

Widget buildResults(search.SearchController controller) {
  return Obx(() {
    if (controller.searchResults.isEmpty) {
      return buildNoResults();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        return RecipeCard(

          recipe: controller.searchResults[index],
          onTap: () {
            Get.to(
                  () => RecipeDetailScreen(
                recipe: controller.searchResults[index],
              ),
            );
          },
        );
      },
    );
  });
}
