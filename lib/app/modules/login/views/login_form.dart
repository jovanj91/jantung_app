import 'package:jantung_app/app/modules/login/controllers/login_controller.dart';
import 'package:jantung_app/app/widgets/custom_tff.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/core/utils/size_config.dart';

class LoginForm extends StatelessWidget {
  final controller = Get.find<LoginController>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 12,
              child: CustomTffWidget(
                type: TextInputType.emailAddress,
                text: 'Email',
                onChanged: (v) => this.controller.changeEmail(v),
                onValidate: (v) => this.controller.validateEmail(v),
                onSaved: (v) => this.controller.savedEmail(v),
                initialValue: 'user1@user.com',
              ),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => Icon(
                    Icons.check,
                    color: this.controller.isEmail.value
                        ? Colors.green
                        : Colors.grey,
                  )),
            )
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
            Expanded(
              flex: 12,
              child: Obx(() => CustomTffWidget(
                    obscure: this.controller.obscure.value,
                    text: 'Password',
                    onChanged: (v) => this.controller.changePassword(v),
                    onValidate: (v) => this.controller.validatePassword(v),
                    onSaved: (v) => this.controller.savedPassword(v),
                    initialValue: 'user123',
                  )),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => IconButton(
                  onPressed: () => this.controller.showPass(),
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this.controller.obscure.value
                        ? Colors.grey
                        : Colors.green,
                  ))),
            )
          ],
        ),
      ],
    );
  }
}
