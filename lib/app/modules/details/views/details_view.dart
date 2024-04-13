import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/details/views/heartcheck_form.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import 'package:jantung_app/core/values/constant.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient Detail'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isDataProcessing.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Container(
                  child: Column(children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    width: SizeConfig.screenWidth * 0.88,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          controller.getImage(controller
                              .patient?.patientData.value.patientGender),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                Text(
                                  '${controller.patient?.patientData.value.patientName}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Age : ${controller.patient?.patientData.value.patientAge}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ]),
                        ),
                        SizedBox(height: getProportionateScreenHeight(100)),
                        ElevatedButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Heart Check',
                              content: HeartCheckForm(),
                              textConfirm: 'Ya',
                              onConfirm: () async {
                                controller.detectEchocardiography();
                              },
                              buttonColor: kPrimaryColor,
                              textCancel: 'Tidak',
                            );
                          },
                          child: Text('Check'), // Empty child
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0), // Adjust the value for the desired roundness
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Expanded(
                    child: controller.listHistory.isEmpty
                        ? Center(
                            child: Text('No History Data Yet'),
                          )
                        : SingleChildScrollView(
                            child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text('No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Check Result',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Date Checked',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                            rows: controller.listHistory
                                .asMap()
                                .entries
                                .map((entry) {
                              final datacount = entry.key + 1;
                              final Map<String, dynamic> rowData = entry.value;
                              return DataRow(cells: [
                                DataCell(Text(datacount.toString())),
                                DataCell(Text(rowData['checkResult'])),
                                DataCell(Text(rowData['checkedAt'].toString())),
                              ]);
                            }).toList(),
                          ))),
              ])),
            );
          }
        }));
  }
}
