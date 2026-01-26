import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/recipe.dart';
import 'recipe_controller.dart';

class AddRecipeController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final cookingTimeController = TextEditingController();
  final servingsController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();

  var selectedCategory = 'Italian'.obs;
  var selectedDifficulty = 'Easy'.obs;
  var selectedSpiceLevel = 'Mild'.obs;

  final imagePath = Rx<String?>(null); // New: store picked image path

  final List<String> categories = ["Pakistani",
    'Italian', 'Indian', 'Mexican', 'Asian', 'Dessert', 'Salad', 'Vegetarian', 'Other',
  ];

  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];
  final List<String> spiceLevels = ['Mild', 'Medium', 'Spicy'];

  final ImagePicker _picker = ImagePicker(); // Image picker

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    cookingTimeController.dispose();
    servingsController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    super.onClose();
  }

  void changeCategory(String category) => selectedCategory.value = category;
  void changeDifficulty(String difficulty) => selectedDifficulty.value = difficulty;
  void changeSpiceLevel(String level) => selectedSpiceLevel.value = level;

  /// Pick image from gallery
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  /// Save recipe
  Future<void> saveRecipe() async {
    if (!formKey.currentState!.validate()) return;

    final ingredients = ingredientsController.text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();

    final instructions = instructionsController.text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();

    if (ingredients.isEmpty || instructions.isEmpty) {
      Get.snackbar(
        'Validation Error',
        ingredients.isEmpty
            ? 'Add at least one ingredient'
            : 'Add at least one instruction',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      category: selectedCategory.value,
      cookingTime: int.parse(cookingTimeController.text),
      difficulty: selectedDifficulty.value,
      servings: int.parse(servingsController.text),
      ingredients: ingredients,
      instructions: instructions,
      spiceLevel: selectedSpiceLevel.value,
      imagePath: imagePath.value, // Set image path
      rating: 0.0,
      isFavorite: false,
    );

    final recipeController = Get.find<RecipeController>();
    await recipeController.addRecipe(recipe);
  }
}
