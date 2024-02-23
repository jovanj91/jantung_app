import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/core/values/constant.dart';

class CustomBottomNavigationBar extends Container {
  final controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedBottomNavigationBar.builder(
          itemCount: controller.pages.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? kSecondaryLightColor : kOnPrimaryColor;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                )
              ],
            );
          },
          activeIndex: controller.currentindex.value,
          onTap: (i) => {
            if (i != controller.currentindex.value) {controller.changePage(i)}
          },
          backgroundColor: kPrimaryColor,
          splashColor: kOnPrimaryColor,
          notchAndCornersAnimation: controller.borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          hideAnimationController: controller.hideBottomBarAnimationController,
          shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: kActivateWidget,
          ),
        ));
  }
}
