import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jantung_app/app/modules/navigation/widgets/floating_action_button.dart';
import 'package:jantung_app/app/modules/navigation/widgets/navigation_bar.dart';
import 'package:jantung_app/routes/app_pages.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.HOME,
        onGenerateRoute: this.controller.onGenerateRoute,
      ),
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
