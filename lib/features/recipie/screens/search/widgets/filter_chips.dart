import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/search_controller.dart' as search;



Widget buildFilterChips(search.SearchController controller) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.filters.length,
      itemBuilder: (context, index) {
        final filter = controller.filters[index];

        return Obx(() {
          final isSelected = controller.selectedFilter.value == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                controller.changeFilter(filter);
              },
              selectedColor: Get.theme.colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        });
      },
    ),
  );
}
