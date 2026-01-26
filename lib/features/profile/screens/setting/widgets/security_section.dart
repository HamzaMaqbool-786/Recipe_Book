import 'package:flutter/material.dart';

import '../../../controllers/setting_controller.dart';

Widget buildSecuritySection(SettingsController controller) {
  return Column(
    children: [
      ListTile(
        leading: const Icon(Icons.lock, color: Colors.blue),
        title: const Text('Change Password',
            style: TextStyle(color: Colors.blue)),
        onTap: controller.changePasswordDialog,
      ),
      ListTile(
        leading: const Icon(Icons.delete_forever, color: Colors.red),
        title:
        const Text('Delete Account', style: TextStyle(color: Colors.red)),
        onTap: controller.deleteAccountDialog,
      ),
    ],
  );
}
