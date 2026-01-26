import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/popups/loader.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../recipie/controllers/recipe_controller.dart';

class SettingsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final RecipeController recipeController = Get.find<RecipeController>();

  static const String settingsBoxName = 'settings';
  late Box settingsBox;

  final userName = ''.obs;
  final userEmail = ''.obs;
  final profileImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    settingsBox = await Hive.openBox(settingsBoxName);

    userName.value = authController.currentUser.value;
    userEmail.value = authController.currentUserEmail.value;
    profileImagePath.value =
        settingsBox.get('profileImagePath', defaultValue: '');
  }

  // ================= PROFILE =================

  Future<void> updateUserName(String name) async {
    bool success = await authController.updateProfile(name: name);
    if (success) {
      userName.value = name;
      TLoaders.successSnackBar(title: 'Updated', message: 'Name updated');
    }
  }

  Future<void> updateUserEmail(String email) async {
    bool success = await authController.updateProfile(email: email);
    if (success) {
      userEmail.value = email;
      TLoaders.successSnackBar(title: 'Updated', message: 'Email updated');
    }
  }

  Future<void> pickProfileImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
      await settingsBox.put('profileImagePath', image.path);
      await authController.updateProfile(profileImage: image.path);
      TLoaders.successSnackBar(title: 'Updated', message: 'Profile image updated');
    }
  }

  // ================= DATA =================

  Future<void> clearAllFavorites() async {
    final recipeBox = Hive.box('recipes');
    for (var key in recipeBox.keys) {
      var recipe = recipeBox.get(key);
      if (recipe != null) {
        recipe.isFavorite = false;
        await recipe.save();
      }
    }
    recipeController.loadFavorites();
    TLoaders.successSnackBar(title: 'Done', message: 'Favorites cleared');
  }

  Future<void> clearAllData() async {
    await recipeController.deleteAllRecipes();
    await Hive.deleteBoxFromDisk('recipes');
    await Hive.deleteBoxFromDisk(settingsBoxName);
    TLoaders.successSnackBar(title: 'Done', message: 'All data cleared');
  }

  // ================= PASSWORD =================
  Future<void> changePasswordDialog() async {
    final currentController = TextEditingController();
    final newController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentController,
              decoration: const InputDecoration(labelText: 'Current Password'),
              obscureText: true,
            ),
            TextField(
              controller: newController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              String current = currentController.text;
              String newPass = newController.text;
              if (current.isEmpty || newPass.isEmpty) {
                TLoaders.warningSnackBar(title: 'Error', message: 'Fields cannot be empty');
                return;
              }
              bool success = await authController.changePassword(
                currentPassword: current,
                newPassword: newPass,
              );
              if (success) Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ================= DELETE ACCOUNT =================
  Future<void> deleteAccountDialog() async {
    final passwordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Enter Password'),
          obscureText: true,
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              String password = passwordController.text;
              if (password.isEmpty) {
                TLoaders.warningSnackBar(title: 'Error', message: 'Password required');
                return;
              }
              bool success = await authController.deleteAccount(password);
              if (success) Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ================= ABOUT =================

  void showDeveloperInfo() {
    Get.dialog(
      AlertDialog(
        title: const Text('Developer'),
        content: const Text(
            'Hamza Maqbool\nFlutter Developer\nGetX + Hive'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Close')),
        ],
      ),
    );
  }
}
