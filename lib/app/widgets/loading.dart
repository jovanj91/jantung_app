import 'package:jantung_app/core/utils/size_config.dart';
import 'package:jantung_app/core/values/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingWidget extends Container {
  CustomLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SpinKitPumpingHeart(
      color: kSurfaceColor,
      size: SizeConfig.wp(32.0),
    );
  }
}
