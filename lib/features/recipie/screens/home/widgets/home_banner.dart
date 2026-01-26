import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/banner_controller.dart';

class HomeBanner extends StatelessWidget implements PreferredSize {
  const HomeBanner({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    controller.pageController=PageController(viewportFraction: 0.95);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Obx(() {
          if (controller.banners.isEmpty) return const SizedBox();

          // Match status bar color with your AppBar color
          return Column(
            children: [
              SizedBox(
                height: 260,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.banners.length,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    final banner = controller.banners[index];
                    return Transform.scale(
                      scale: controller.currentIndex.value == index ? 1.0 : 0.95,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.shade200.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                banner['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                banner['subtitle'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: List<Widget>.from(
                                  (banner['icons'] as List<IconData>).map(
                                        (icon) => Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Icon(
                                        icon,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.banners.length,
                      (i) => Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 10,
                    width: controller.currentIndex.value == i ? 24 : 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.currentIndex.value == i
                          ? Colors.orange.shade900
                          : Colors.orange.shade200,
                    ),
                  )),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(300);
}
