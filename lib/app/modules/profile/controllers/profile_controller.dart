import 'package:jantung_app/app/data/services/auth/service.dart';

import 'package:jantung_app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  AuthService? auth;

  @override
  void onInit() {
    this.auth = Get.find<AuthService>();
    super.onInit();
  }

  logout() async {
    var data = await this.auth?.logout();
    if (data == null) {
      Get.snackbar('Login Failed', 'Unexpected Error',
          snackPosition: SnackPosition.TOP);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
