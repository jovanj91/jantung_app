import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/widgets/default_button.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                          children: [
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
                                      controller.getImage(index).toString(),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                        width: getProportionateScreenWidth(20)),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            Text(
                                              '${controller.listPatient[index]['patient_name']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        55)),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Icon(Icons
                                                  .arrow_forward_ios_rounded), // Empty child
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0), // Adjust the value for the desired roundness
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
