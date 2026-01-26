import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/profile/screens/setting/widgets/about_section.dart';
import 'package:recipe_book/features/profile/screens/setting/widgets/data_section.dart';
import 'package:recipe_book/features/profile/screens/setting/widgets/profile_section.dart';
import 'package:recipe_book/features/profile/screens/setting/widgets/security_section.dart';
import 'package:recipe_book/features/profile/screens/setting/widgets/statistic_Section.dart';

import '../../../recipie/controllers/recipe_controller.dart';
import '../../controllers/setting_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());
    final RecipeController recipeController = Get.find<RecipeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildProfileSection(controller),
          const Divider(),
          buildStatisticsSection(recipeController),
          const Divider(),
          buildDataSection(controller),
          const Divider(),
          buildSecuritySection(controller),
          const Divider(),
          buildAboutSection(controller),
          const SizedBox(height: 80),
        ],
      ),
    );
  }


}
