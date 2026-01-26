import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipie/screens/add_recipe/widgets/Recipe_Image_picker.dart';
import 'package:recipe_book/features/recipie/screens/add_recipe/widgets/category_drop_down.dart';
import 'package:recipe_book/features/recipie/screens/add_recipe/widgets/choice_chip_selector.dart';
import 'package:recipe_book/features/recipie/screens/add_recipe/widgets/custom_text_field.dart';
import 'package:recipe_book/features/recipie/screens/add_recipe/widgets/number_field.dart';

import '../../controllers/add_recipe_controller.dart';


class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddRecipeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: controller.saveRecipe,
          ),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RecipeImagePicker(controller: controller),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.nameController,
              label: 'Recipe Name *',
              icon: Icons.restaurant_menu,
              validator: (value) =>
              value == null || value.isEmpty ? 'Please enter recipe name' : null,
            ),
            const SizedBox(height: 16),
            CategoryDropdown(controller: controller),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: NumberField(
                    controller: controller.cookingTimeController,
                    label: 'Time (min) *',
                    icon: Icons.access_time,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    controller: controller.servingsController,
                    label: 'Servings *',
                    icon: Icons.people,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ChoiceChipSelector(
              title: 'Difficulty',
              items: controller.difficulties,
              selectedItem: controller.selectedDifficulty,
              onChanged: controller.changeDifficulty,
            ),
            const SizedBox(height: 16),
            ChoiceChipSelector(
              title: 'Spice Level',
              items: controller.spiceLevels,
              selectedItem: controller.selectedSpiceLevel,
              onChanged: controller.changeSpiceLevel,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.descriptionController,
              label: 'Description',
              icon: Icons.description,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.ingredientsController,
              label: 'Ingredients (one per line) *',
              icon: Icons.shopping_cart,
              maxLines: 8,
              hintText: 'Example:\n400g Spaghetti\n200g Bacon\n4 Eggs',
              validator: (value) =>
              value == null || value.isEmpty ? 'Please enter at least one ingredient' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.instructionsController,
              label: 'Instructions (one step per line) *',
              icon: Icons.format_list_numbered,
              maxLines: 10,
              hintText: 'Example:\nBoil water...\nCook pasta...\nMix ingredients...',
              validator: (value) =>
              value == null || value.isEmpty ? 'Please enter cooking instructions' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.saveRecipe,
              icon: const Icon(Icons.save),
              label: const Text('Save Recipe'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}







