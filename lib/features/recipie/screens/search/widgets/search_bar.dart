import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controllers/search_controller.dart' as search;



Widget buildSearchBar(search.SearchController controller) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: TextField(
      controller: controller.searchTextController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Search recipes...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Obx(() => controller.isSearching.value
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: controller.clearSearch,
        )
            : const SizedBox.shrink()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    ),
  );
}
