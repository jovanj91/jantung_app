import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/core/values/constant.dart';

class CustomFloatingActionButton extends Container {
  final controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Obx(() => Icon(
            controller.iconList[controller.currentindex.value],
            color: kOnPrimaryColor,
          )),
      onPressed: () {
        controller.fabAnimationController.reset();
        controller.borderRadiusAnimationController.reset();
        controller.borderRadiusAnimationController.forward();
        controller.fabAnimationController.forward();
      },
    );
  }
}
