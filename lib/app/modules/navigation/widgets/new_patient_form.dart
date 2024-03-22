import 'package:jantung_app/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:jantung_app/app/widgets/custom_tff.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import 'package:jantung_app/core/values/constant.dart';

class NewPatientForm extends StatelessWidget {
  final controller = Get.find<NavigationController>();

  NewPatientForm({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 10,
              child: CustomTffWidget(
                type: TextInputType.name,
                text: 'Name',
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: CustomTffWidget(
                text: 'Gender',
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Obx(() => Text(
                    controller.dateOutput(),
                    style: TextStyle(color: kInacvtiveWidget),
                  )),
            ),
            Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: () => controller.chooseDate(),
                    icon: Icon(
                      Icons.calendar_month,
                      color: kPrimaryColor,
                    )))
          ],
        ),
      ],
    );
  }
}
