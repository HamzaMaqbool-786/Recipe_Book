import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BannerController extends GetxController {
  var banners = <Map<String, dynamic>>[].obs; // <- RxList

  var currentIndex = 0.obs;
  var pageController = PageController(viewportFraction: 0.85);

  @override
  void onInit() {
    super.onInit();
    loadBanners();
  }

  void loadBanners() {
    banners.value = [
      {
        'title': 'Delicious Recipes',
        'subtitle': 'Cook amazing food at home',
        'icons': [Icons.restaurant_menu, Icons.local_pizza, Icons.local_dining],
      },
      {
        'title': 'Healthy Meals',
        'subtitle': 'Eat fresh & stay fit',
        'icons': [Icons.spa, Icons.emoji_food_beverage, Icons.local_dining],
      },
      {
        'title': 'Quick Snacks',
        'subtitle': 'Ready in 15 minutes',
        'icons': [Icons.fastfood, Icons.cake, Icons.local_cafe],
      },
    ];
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
