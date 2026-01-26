
import 'package:flutter/material.dart';

import '../../../../../data/models/recipe.dart';

import '../../../../../utils/helper/helper_functions.dart';
import 'info_item.dart';

Widget buildInfoBar(Recipe recipe, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildInfoItem(
          icon: Icons.access_time,
          label: '${recipe.cookingTime} min',
          context: context,
        ),
        buildInfoItem(
          icon: Icons.person,
          label: recipe.difficulty,
          context: context,
        ),
        buildInfoItem(
          icon: Icons.restaurant,
          label: '${recipe.servings} servings',
          context: context,
        ),
        buildInfoItem(
          icon: Icons.local_fire_department,
          label: recipe.spiceLevel,
          color: HelperFunction.getSpiceColor(recipe.spiceLevel),
          context: context,
        ),
      ],
    ),
  );
}
