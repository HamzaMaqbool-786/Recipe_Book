import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/recipe.dart';
import '../../../data/services/database_helper.dart';





class SearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  var searchResults = <Recipe>[].obs;
  var isSearching = false.obs;
  var selectedFilter = 'All'.obs;

  final List<String> filters = ['All', 'Easy', 'Quick', 'Vegetarian'];

  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    final query = searchTextController.text;
    isSearching.value = query.isNotEmpty;

    if (isSearching.value) {
      searchResults.value = DatabaseHelper.searchRecipes(query);
      _applyFilter();
    } else {
      searchResults.clear();
    }
  }

  void _applyFilter() {
    if (selectedFilter.value == 'All') return;

    switch (selectedFilter.value) {
      case 'Easy':
        searchResults.value = searchResults
            .where((r) => r.difficulty == 'Easy')
            .toList();
        break;
      case 'Quick':
        searchResults.value = searchResults
            .where((r) => r.cookingTime <= 30)
            .toList();
        break;
      case 'Vegetarian':
        searchResults.value = searchResults
            .where((r) => r.category.toLowerCase() == 'vegetarian' ||
            r.name.toLowerCase().contains('veg'))
            .toList();
        break;
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    _onSearchChanged();
  }

  void clearSearch() {
    searchTextController.clear();
    searchResults.clear();
    isSearching.value = false;
  }

  void sortResults(String sortBy) {
    switch (sortBy) {
      case 'name':
        searchResults.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'time':
        searchResults.sort((a, b) => a.cookingTime.compareTo(b.cookingTime));
        break;
      case 'rating':
        searchResults.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    searchResults.refresh();
  }

  void performSearch(String query) {
    searchTextController.text = query;
  }
}