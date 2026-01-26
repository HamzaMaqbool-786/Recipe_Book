import 'package:flutter/cupertino.dart';
import 'package:recipe_book/features/authentication/screens/onboarding/widgets/page_content.dart';

import '../../../controllers/onBoarding_controller.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.controller,
  });

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.pages.length,
        onPageChanged: (int page) {
          controller.currentPage.value = page;
        },
        itemBuilder: (context, index) {
          return PageContent(page: controller.pages[index],);
        },
      ),
    );
  }
}
