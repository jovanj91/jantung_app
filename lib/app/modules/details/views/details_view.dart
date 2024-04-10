import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jantung_app/core/utils/size_config.dart';

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
            return Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
                            controller.getImage().toString(),
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
                                    '${controller.listHistory[0]['patientName']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Age : ${controller.listHistory[0]['patientAge']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ]));
          }
        }));
  }
}
