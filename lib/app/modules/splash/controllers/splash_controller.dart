import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  AuthService? auth;

  final count = 0.obs;
  @override
  void onInit() {
    this.auth = Get.find<AuthService>();
    super.onInit();
  }

  @override
  void onReady() {
    if (this.auth?.getJwtToken() != "" &&
        this.auth?.getJwtToken() != null &&
        this.auth?.checkForValidToken() == true) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.NAVIGATION);
      });
    } else {
      this.auth?.clearJwtToken();
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.LOGIN);
        // Get.offAllNamed(Routes.NAVIGATION);
      });
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
