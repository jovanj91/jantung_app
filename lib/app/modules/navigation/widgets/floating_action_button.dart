import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/app/modules/navigation/widgets/new_patient_form.dart';
import 'package:jantung_app/core/values/constant.dart';

class CustomFloatingActionButton extends Container {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          content: Form(
            key: _formKey,
            child: NewPatientForm(),
          ),
          textConfirm: 'Ya',
          onConfirm: () async {
            final FormState form = _formKey.currentState!;
            if (form.validate()) {
              form.save();
              await this.controller.addPatient();
            }
          },
          buttonColor: kPrimaryColor,
          textCancel: 'Tidak',
        );
      },
    );
  }
}
