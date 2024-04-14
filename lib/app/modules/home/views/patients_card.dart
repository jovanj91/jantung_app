import 'package:jantung_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/core/utils/size_config.dart';

class PatientCard extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final index;
  PatientCard({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: EdgeInsets.all(15.0),
        width: SizeConfig.screenWidth * 0.95,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              controller.getImage(index),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      '${controller.listPatient[index]['patientName']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            Expanded(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SizedBox(height: getProportionateScreenHeight(55)),
                ElevatedButton(
                  onPressed: () {
                    controller.savedPatientName(
                        controller.listPatient[index]['patientName']);
                    controller.savedPatientAge(
                        controller.listPatient[index]['patientAge']);
                    controller.savedPatientGender(
                        controller.listPatient[index]['patientGender']);
                    controller.getPatientDetails(
                        controller.listPatient[index]['patientId']);
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded), // Empty child
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50.0), // Adjust the value for the desired roundness
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
