import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controllers/add_recipe_controller.dart';

class CategoryDropdown extends StatelessWidget {
  final AddRecipeController controller;
  const CategoryDropdown({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => DropdownButtonFormField<String>(
        value: controller.selectedCategory.value,
        decoration: const InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.category),
        ),
        items: controller.categories
            .map((category) => DropdownMenuItem(
          value: category,
          child: Text(category),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) controller.changeCategory(value);
        },
      ),
    );
  }
}
