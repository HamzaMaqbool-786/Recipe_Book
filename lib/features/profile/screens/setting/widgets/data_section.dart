import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../authentication/controllers/auth_controller.dart';
import '../../../controllers/setting_controller.dart';

Widget buildDataSection(SettingsController controller) {
  return Column(
    children: [
      ListTile(
        leading: const Icon(Icons.favorite_border, color: Colors.orange),
        title: const Text('Clear Favorites'),
        onTap: controller.clearAllFavorites,
      ),
      ListTile(
        leading: const Icon(Icons.delete, color: Colors.red),
        title:
        const Text('Clear All Data', style: TextStyle(color: Colors.red)),
        onTap: controller.clearAllData,
      ),
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text('Logout', style: TextStyle(color: Colors.red)),
        onTap: () => Get.find<AuthController>().logout(),
      ),
    ],
  );
}
