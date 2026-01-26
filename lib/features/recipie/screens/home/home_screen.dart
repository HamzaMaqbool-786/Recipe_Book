import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipie/screens/home/widgets/home_banner.dart';


import '../../../../utils/common/widgets/recipe_card.dart';
import '../../controllers/recipe_controller.dart';
import '../add_recipe/add_recipe_screen.dart';
import '../recipe_detail/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeController controller = Get.put(RecipeController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFF6B35),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const AddRecipeScreen()),
      ),
      backgroundColor: Colors.grey.shade100,

      //  Banner widget
      appBar: const HomeBanner(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Popular Recipes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                if (controller.filteredRecipes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No recipes found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = controller.filteredRecipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () => Get.to(() => RecipeDetailScreen(recipe: recipe)),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
