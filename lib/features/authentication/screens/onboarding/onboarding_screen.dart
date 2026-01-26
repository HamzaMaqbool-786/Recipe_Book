import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/authentication/screens/onboarding/widgets/bottom_btns.dart';
import 'package:recipe_book/features/authentication/screens/onboarding/widgets/page_indicator.dart';
import 'package:recipe_book/features/authentication/screens/onboarding/widgets/page_view_widget.dart';
import 'package:recipe_book/features/authentication/screens/onboarding/widgets/skip_btn.dart';
import '../../controllers/onBoarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});









  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            SkipButton(controller: controller),

            // PageView
            PageViewWidget(controller: controller),

            // Page indicators
            const PageIndicator(),

            // Bottom buttons
            BottomButtuns(controller: controller),
          ],
        ),
      ),
    );
  }
}



