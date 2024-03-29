import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/app/modules/navigation/widgets/new_patient_form.dart';
import 'package:jantung_app/core/values/constant.dart';

class CustomFloatingActionButton extends Container {
  final controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        // controller.iconList[controller.currentindex.value],
        Icons.add,
        color: kOnPrimaryColor,
      ),
      onPressed: () {
        // controller.fabAnimationController.reset();
        // controller.borderRadiusAnimationController.reset();
        // controller.borderRadiusAnimationController.forward();
        // controller.fabAnimationController.forward();
        Get.defaultDialog(
          title: 'Tambah Data Pasien',
          content: NewPatientForm(),
          textConfirm: 'Ya',
          buttonColor: kPrimaryColor,
          textCancel: 'Tidak',
        );
      },
    );
  }
}
