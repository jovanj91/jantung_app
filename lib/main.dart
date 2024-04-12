import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/app.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';
import 'app/modules/home/controllers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => PreprocessingService().init());
  await Get.putAsync(() => PatientService().init());
  Get.lazyPut(() => HomeController());
  runApp(MyApp());
}
