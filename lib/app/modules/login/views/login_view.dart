import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/login/views/login_form.dart';
import 'package:jantung_app/app/widgets/default_button.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import 'package:jantung_app/core/values/constant.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (controller.processingLogin.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
                child: Stack(
              children: [
                Container(
                  height: SizeConfig.hp(100.0),
                  width: SizeConfig.wp(100.0),
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.1),
                      Container(
                        child: Column(
                          children: [
                            Text("Welcome to JantungApp",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(24),
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                            Text(
                                "Please Sign In with Your Email \n and Password on Form Below",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: getProportionateScreenWidth(14),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: SizeConfig.hp(2.0),
                        width: SizeConfig.wp(32.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginForm(),
                              Container(
                                margin: EdgeInsets.only(top: 24.0),
                                width: SizeConfig.wp(30.0),
                                child: DefaultButton(
                                  callback: () async {
                                    final FormState form =
                                        _formKey.currentState!;
                                    if (form.validate()) {
                                      form.save();
                                      await this.controller.login();
                                    }
                                  },
                                  text: 'Login',
                                  icon: Icons.login,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }
        }));
  }
}
