import 'package:flutter/material.dart';

import '../../../controllers/setting_controller.dart';

Widget buildAboutSection(SettingsController controller) {
  return Column(
    children: [
      const ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('Version'),
        subtitle: Text('1.0.0'),
      ),
      ListTile(
        leading: const Icon(Icons.code),
        title: const Text('Developer'),
        subtitle: const Text('Hamza Maqbool'),
        onTap: controller.showDeveloperInfo,
      ),
    ],
  );
}
