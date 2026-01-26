import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controllers/search_controller.dart' as search;


Widget buildResultsHeader(search.SearchController controller) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Obx(() => Text(
          'Results (${controller.searchResults.length})',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
        const Spacer(),
        Obx(() => controller.searchResults.isNotEmpty
            ? PopupMenuButton<String>(
          onSelected: controller.sortResults,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'name',
              child: Text('Name'),
            ),
            const PopupMenuItem(
              value: 'time',
              child: Text('Cooking Time'),
            ),
            const PopupMenuItem(
              value: 'rating',
              child: Text('Rating'),
            ),
          ],
          child: Row(
            children: [
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        )
            : const SizedBox.shrink()),
      ],
    ),
  );
}
