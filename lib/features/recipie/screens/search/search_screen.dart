import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipie/screens/search/widgets/empty_state_widget.dart';
import 'package:recipe_book/features/recipie/screens/search/widgets/filter_chips.dart';
import 'package:recipe_book/features/recipie/screens/search/widgets/result_header.dart';
import 'package:recipe_book/features/recipie/screens/search/widgets/result_widget.dart';
import 'package:recipe_book/features/recipie/screens/search/widgets/search_bar.dart';

import '../../../../utils/helper/helper_functions.dart';
import '../../controllers/search_controller.dart' as search;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(search.SearchController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
      ),
      body: GestureDetector(
        // This will dismiss the keyboard when tapping anywhere outside the TextField
        onTap: ()=>HelperFunction.hideKeyboard(context),
        behavior: HitTestBehavior.opaque,

        child: Column(
          children: [
            // Search Bar
            buildSearchBar(controller),

            // Filter Chips
            Obx(() => controller.isSearching.value
                ? buildFilterChips(controller)
                : const SizedBox.shrink()),

            // Results Count
            Obx(() => controller.isSearching.value
                ? buildResultsHeader(controller)
                : const SizedBox.shrink()),

            const Divider(height: 1),

            // Search Results or Empty State
            Expanded(
              child: Obx(() => controller.isSearching.value
                  ? buildResults(controller)
                  : buildEmptyState(controller)),
            ),
          ],
        ),
      ),
    );
  }





}