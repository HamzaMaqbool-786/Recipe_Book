import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/onBoarding_controller.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnBoardingController>();

     return Obx(
       ()=> Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.pages.length,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: controller.currentPage.value == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: controller.currentPage.value == index
                  ? controller.pages[controller.currentPage.value].color
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
           ),
     );
  }
}
