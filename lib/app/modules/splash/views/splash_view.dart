import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import 'package:jantung_app/core/values/constant.dart';
import '../controllers/splash_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Container(
          height: SizeConfig.hp(100.0),
          width: SizeConfig.wp(100.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.2),
              SpinKitPumpingHeart(
                color: kSurfaceColor,
                size: SizeConfig.wp(30.0),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              const Text(
                'Jantung App',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kOnPrimaryColor),
              )
            ],
          ),
        ),
      )),
    );
  }
}
