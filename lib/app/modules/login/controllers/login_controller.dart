import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:jantung_app/routes/app_pages.dart';

class LoginController extends GetxController {
  AuthService? auth;

  final isEmail = false.obs;
  final obscure = true.obs;
  var processingLogin = false.obs;

  @override
  void onInit() {
    this.auth = Get.find<AuthService>();
    super.onInit();
  }

  login() async {
    try {
      processingLogin(true);
      await this
          .auth
          ?.login(
              this.auth?.user.value.useremail, this.auth?.user.value.password)
          .then((response) {
        print(response);
        if (VerifyError.verify(response)) {
          Get.snackbar('Login Failed', response.getError(),
              snackPosition: SnackPosition.TOP);
          processingLogin(false);
        } else {
          Get.offAllNamed(Routes.NAVIGATION);
        }
      }, onError: (err) {
        processingLogin(false);
        Get.snackbar('Login Failed', err.toString(),
            snackPosition: SnackPosition.TOP);
      });
    } catch (e) {
      processingLogin(false);
      Get.snackbar('Login Failed', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  showPass() => this.obscure.value = !this.obscure.value;
  changeEmail(v) {
    if (GetUtils.isEmail(v)) {
      this.auth?.user.update((user) => user?.useremail = v);
      this.isEmail.value = true;
    } else {
      this.isEmail.value = false;
    }
  }

  validateEmail(v) => GetUtils.isEmail(v) ? null : 'Email Invalid.';
  savedEmail(v) => this.auth?.user.update((user) => user?.useremail = v);

  changePassword(v) {
    if (v.length > 3) {
      this.auth?.user.update((user) => user?.password = v);
    } else {}
  }

  validatePassword(v) => v.length > 3 ? null : 'Password Invalid';
  savedPassword(v) => this.auth?.user.update((user) => user?.password = v);
}
