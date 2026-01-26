import 'package:flutter/material.dart';

import '../../../controllers/onBoarding_controller.dart';

class BottomButtuns extends StatelessWidget {
  const BottomButtuns({
    super.key,
    required this.controller,
  });

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          if (controller.currentPage.value > 0)
            TextButton(
              onPressed: () {
                controller.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Back'),
            )
          else
            const SizedBox(width: 80),

          // Next/Get Started button
          ElevatedButton(
            onPressed: () {
              if (controller.currentPage.value < controller.pages.length - 1) {
                controller.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                controller.completeOnboarding();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              controller.currentPage.value < controller.pages.length - 1
                  ? 'Next'
                  : 'Get Started',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}