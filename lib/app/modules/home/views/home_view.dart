import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/home/views/patients_card.dart';
import 'package:jantung_app/app/widgets/default_button.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isDataProcessing.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (controller.listPatient.length > 0) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.listPatient.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.listPatient.length - 1 &&
                            controller.isMoreDataAvailable.value == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [PatientCard(index: index)],
                        ));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Data not found',
                style: TextStyle(fontSize: 25),
              ),
            );
          }
        }
      }),
    );
  }
}
