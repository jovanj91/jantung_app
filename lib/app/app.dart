import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:jantung_app/core/theme/theme.dart';

import '/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      theme: theme(),
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
