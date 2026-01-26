import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_book/data/sample_data.dart';
import '../models/recipe.dart';

class DatabaseHelper {
  static const String recipeBoxName = 'recipes';
  static const String settingsBoxName = 'settings';


  static Box<Recipe>? _recipeBox;
  static Box? _settingsBox;

  //  INIT Fn
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RecipeAdapter()); // Recipe = typeId 0
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ImageTypeAdapter()); // ImageType = typeId 1
    }

    // Open boxes
    _recipeBox = await Hive.openBox<Recipe>(recipeBoxName);
    _settingsBox = await Hive.openBox(settingsBoxName);

    // First launch setup
    final bool isFirstLaunch =
    _settingsBox!.get('first_launch', defaultValue: true);

// First install OR recipes deleted  restore sample data
    if (_recipeBox!.isEmpty) {
      await _addSampleRecipes();

      if (isFirstLaunch) {
        await _settingsBox!.put('first_launch', false);
      }
    }
  }

  // ================= BOX GETTERS =================
  static Box<Recipe> get recipeBox {
    if (_recipeBox == null || !_recipeBox!.isOpen) {
      throw Exception('Recipe box not initialized');
    }
    return _recipeBox!;
  }

  static Box get settingsBox {
    if (_settingsBox == null || !_settingsBox!.isOpen) {
      throw Exception('Settings box not initialized');
    }
    return _settingsBox!;
  }

  // CRUD operations
  static Future<void> addRecipe(Recipe recipe) async {
    await recipeBox.put(recipe.id, recipe);
  }

  static List<Recipe> getAllRecipes() => recipeBox.values.toList();

  static Recipe? getRecipe(String id) => recipeBox.get(id);

  static Future<void> updateRecipe(Recipe recipe) async {
    await recipeBox.put(recipe.id, recipe);
  }

  static Future<void> deleteRecipe(String id) async {
    await recipeBox.delete(id);
  }

  // FAVORITES
  static Future<void> toggleFavorite(String id) async {
    final recipe = recipeBox.get(id);
    if (recipe != null) {
      recipe.isFavorite = !recipe.isFavorite;
      await recipe.save();
    }
  }

  static List<Recipe> getFavoriteRecipes() =>
      recipeBox.values.where((r) => r.isFavorite).toList();

  static Future<void> clearFavorites() async {
    for (final recipe in recipeBox.values) {
      if (recipe.isFavorite) {
        recipe.isFavorite = false;
        await recipe.save();
      }
    }
  }

  //  CLEAR DATA
  static Future<void> clearAllRecipes() async => await recipeBox.clear();

  //  SEARCH & FILTER
  static List<Recipe> searchRecipes(String query) {
    final q = query.toLowerCase();
    return recipeBox.values.where((recipe) {
      return recipe.name.toLowerCase().contains(q) ||
          recipe.category.toLowerCase().contains(q) ||
          recipe.ingredients.any((i) => i.toLowerCase().contains(q));
    }).toList();
  }

  static List<Recipe> getRecipesByCategory(String category) =>
      recipeBox.values.where((r) => r.category == category).toList();

  static List<Recipe> getRecipesByDifficulty(String difficulty) =>
      recipeBox.values.where((r) => r.difficulty == difficulty).toList();

  static List<Recipe> getQuickRecipes() =>
      recipeBox.values.where((r) => r.cookingTime <= 30).toList();

  //  SAMPLE DATA ]
  static Future<void> _addSampleRecipes() async {
    for (final recipe in SampleData.sampleRecipes) {
      await addRecipe(recipe);
    }
  }

  // Delete ALL recipes
  static Future<void> deleteAllRecipes() async => await recipeBox.clear();
}
