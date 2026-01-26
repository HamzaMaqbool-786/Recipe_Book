import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/sign-up/sign-up.dart';
import 'auth_controller.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final AuthController authController = Get.find<AuthController>();

  RxInt currentPage = 0.obs;
  final PageController pageController = PageController();

  final List<OnboardingPage> pages = [
    OnboardingPage(
      icon: Icons.restaurant_menu,
      title: 'Discover Recipes',
      description: 'Browse through hundreds of delicious recipes from around the world',
      color: const Color(0xFFFF6B35),
    ),
    OnboardingPage(
      icon: Icons.favorite,
      title: 'Save Favorites',
      description: 'Mark your favorite recipes and access them anytime, anywhere',
      color: const Color(0xFFE63946),
    ),
    OnboardingPage(
      icon: Icons.search,
      title: 'Search & Filter',
      description: 'Find the perfect recipe with our powerful search and filter tools',
      color: const Color(0xFFF7931E),
    ),
    OnboardingPage(
      icon: Icons.shopping_cart,
      title: 'Cook & Enjoy',
      description: 'Follow step-by-step instructions and create amazing dishes',
      color: const Color(0xFF4CAF50),
    ),
  ];

  void skipOnboarding() {
    authController.completeOnboarding();
    Get.off(() => const SignupScreen());
  }

  void completeOnboarding() {

    authController.completeOnboarding();
    Get.off(() => const SignupScreen());
  }


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
