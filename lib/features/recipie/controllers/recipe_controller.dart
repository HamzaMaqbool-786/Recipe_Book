import 'package:get/get.dart';
import '../../../data/models/recipe.dart';
import '../../../data/services/database_helper.dart';
import '../../../utils/popups/loader.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var filteredRecipes = <Recipe>[].obs;
  var favoriteRecipes = <Recipe>[].obs;

  var isLoading = false.obs;
  var selectedFilter = 'All'.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  void loadRecipes() {
    try {
      isLoading.value = true;
      recipes.value = DatabaseHelper.getAllRecipes();
      applyFilter();
      loadFavorites();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to load recipes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    switch (selectedFilter.value) {
      case 'All':
        filteredRecipes.value = recipes;
        break;
      case 'Quick':
        filteredRecipes.value =
            recipes.where((r) => r.cookingTime <= 30).toList();
        break;
      case 'Easy':
        filteredRecipes.value =
            recipes.where((r) => r.difficulty == 'Easy').toList();
        break;
      default:
        filteredRecipes.value = recipes;
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void loadFavorites() {
    favoriteRecipes.value = recipes.where((r) => r.isFavorite).toList();
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      await DatabaseHelper.addRecipe(recipe);
      recipes.add(recipe);
      applyFilter();
      Get.back();
      TLoaders.successSnackBar(
          title: 'Success', message: 'Recipe added successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to add recipe: $e');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await DatabaseHelper.updateRecipe(recipe);
      final index = recipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        recipes[index] = recipe;
        applyFilter();
        loadFavorites();
      }
      TLoaders.successSnackBar(
          title: 'Updated', message: 'Recipe updated successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to update recipe: $e');
    }
  }

  Future<void> deleteRecipe(String id) async {
    try {
      await DatabaseHelper.deleteRecipe(id);
      recipes.removeWhere((r) => r.id == id);
      applyFilter();
      loadFavorites();
      Get.back(); // Close detail screen
      TLoaders.successSnackBar(
          title: 'Deleted', message: 'Recipe deleted successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to delete recipe: $e');
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      final index = recipes.indexWhere((r) => r.id == id);
      if (index == -1) return;

      final recipe = recipes[index];
      recipe.isFavorite = !recipe.isFavorite;
      await recipe.save(); // Hive save
      recipes[index] = recipe;
      loadFavorites();
      applyFilter();

      TLoaders.customToast(
          message: recipe.isFavorite
              ? 'Added to favorites'
              : 'Removed from favorites');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to update favorite');
    }
  }

  Future<void> deleteAllRecipes() async {
    try {
      await DatabaseHelper.deleteAllRecipes();
      recipes.clear();
      filteredRecipes.clear();
      favoriteRecipes.clear();
      TLoaders.successSnackBar(
          title: 'Deleted', message: 'All recipes deleted successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to delete recipes: $e');
    }
  }

  Recipe? getRecipeById(String id) {
    try {
      return recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  void searchRecipes(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredRecipes.value = recipes;
      return;
    }

    final results = DatabaseHelper.searchRecipes(query);
    filteredRecipes.value = results;
  }

  void filterByCategory(String category) {
    filteredRecipes.value = DatabaseHelper.getRecipesByCategory(category);
  }

  void filterByDifficulty(String difficulty) {
    filteredRecipes.value = DatabaseHelper.getRecipesByDifficulty(difficulty);
  }

  void getQuickRecipes() {
    filteredRecipes.value = DatabaseHelper.getQuickRecipes();
  }

  void sortRecipes(String sortBy) {
    switch (sortBy) {
      case 'name':
        filteredRecipes.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'time':
        filteredRecipes.sort((a, b) => a.cookingTime.compareTo(b.cookingTime));
        break;
      case 'rating':
        filteredRecipes.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    filteredRecipes.refresh();
  }

  int get recipeCount => recipes.length;

  int get favoriteCount => favoriteRecipes.length;

  void clearAllFavorites() {
    DatabaseHelper.clearFavorites();
    loadFavorites();
    TLoaders.customToast(message: 'All favorites cleared');
  }
}
