import 'package:jantung_app/app/data/models/user.dart';
import 'package:jantung_app/app/data/provider/api.dart';
import 'package:jantung_app/app/data/services/auth/repository.dart';
import 'package:jantung_app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    this.repository = AuthRepository(MyApi());
    return this;
  }

  final jwtToken = ''.obs;
  AuthRepository? repository;
  final user = User().obs;
  final box = GetStorage();
  static const String _jwtKey = 'jwt_token';

  Future<void> storeJwtToken(String token) async {
    box.write(_jwtKey, token);
  }

  Future<void> getJwtToken() async {
    box.read(_jwtKey);
  }

  Future<void> clearJwtToken() async {
    box.remove(_jwtKey);
  }

  bool checkForValidToken() {
    try {
      if (JwtDecoder.isExpired(jwtToken.value)) {
        print('JWT Token has expired.');
        return false;
      }
      return true;
    } catch (e) {
      print('Error while validating JWT token: $e');
      return false;
    }
  }

  login(email, password) async {
    var data = await repository?.login(email, password);
    storeJwtToken(jwtToken.value);
    return data;
  }

  logout() {
    clearJwtToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
