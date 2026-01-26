import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/setting_controller.dart';

Widget buildProfileSection(SettingsController controller) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: controller.pickProfileImage,
            child: Obx(() {
              return Stack(
                children: [
                CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange,
                backgroundImage: controller.profileImagePath.value.isNotEmpty
                    ? FileImage(File(controller.profileImagePath.value))
                    : null,
                child: controller.profileImagePath.value.isEmpty
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
                const Positioned(
                    bottom: 8,
                    right: 3,


                    child: Icon(Icons.camera_alt, size: 30, color: Colors.black)) ,
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Name'),
          subtitle: Text(controller.userName.value),
          trailing: const Icon(Icons.edit),
          onTap: () => _editDialog(
            'Edit Name',
            controller.userName.value,
            controller.updateUserName,
          ),
        )),
        Obx(() => ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: Text(controller.userEmail.value),
          trailing: const Icon(Icons.edit),
          onTap: () => _editDialog(
            'Edit Email',
            controller.userEmail.value,
            controller.updateUserEmail,
          ),
        )),
      ],
    ),
  );

}
void _editDialog(String title, String value, Function(String) onSave) {
  final textController = TextEditingController(text: value);

  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: TextField(controller: textController),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            if (textController.text.isNotEmpty) {
              onSave(textController.text);
              Get.back();
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
