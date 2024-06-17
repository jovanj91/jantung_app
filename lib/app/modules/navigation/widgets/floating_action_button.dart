import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/app/modules/navigation/widgets/new_patient_form.dart';
import 'package:jantung_app/core/values/constant.dart';

class CustomFloatingActionButton extends Container {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: kOnPrimaryColor,
      ),
      onPressed: () {
        //Animation
        controller.fabAnimationController.reset();
        controller.borderRadiusAnimationController.reset();
        controller.borderRadiusAnimationController.forward();
        controller.fabAnimationController.forward();

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return MyAlertDialog();
          },
        );
      },
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDataProcessing.value == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the radius as needed
          ),
          title: Text('Add Patient', textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          content: NewPatientForm(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                controller.defaultGender();
                await controller.addPatient();
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    });
  }
}
