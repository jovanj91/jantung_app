import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:jantung_app/routes/app_pages.dart';

class LoginController extends GetxController {
  AuthService? auth;

  final isEmail = false.obs;
  final obscure = true.obs;

  @override
  void onInit() {
    this.auth = Get.find<AuthService>();
    super.onInit();
  }

  login() async {
    var data = await this.auth?.login(
        this.auth?.user.value.useremail, this.auth?.user.value.password);
    if (data == null) {
      Get.snackbar('Login Failed', 'Unexpected Error',
          snackPosition: SnackPosition.TOP);
    }
    if (VerifyError.verify(data)) {
      print(data);
      Get.snackbar('Login Failed', data.errors,
          snackPosition: SnackPosition.TOP);
    } else {
      Get.toNamed(Routes.HOME);
    }
  }

  logout() async {
    var data = await this.auth?.logout();
    if (data == null) {
      Get.snackbar('Login Failed', 'Unexpected Error',
          snackPosition: SnackPosition.TOP);
    } else {
      Get.toNamed(Routes.LOGIN);
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
