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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: CustomTffWidget(
                    type: TextInputType.name,
                    text: 'Name',
                    onChanged: (v) => this.controller.changeName(v),
                    onSaved: (v) => this.controller.savedName(v),
                    onValidate: (v) => this.controller.validateName(v),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                controller.addRadioButton(0, 'Male'),
                controller.addRadioButton(1, 'Female'),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Obx(() => CustomTffWidget(
                        readonly: true,
                        controller: TextEditingController(
                            text: controller.dateOutput()),
                        text: 'Date of Birth',
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
        ),
      ),
    );
  }
}
