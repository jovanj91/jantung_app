import 'package:jantung_app/app/data/models/user.dart';
import 'package:jantung_app/app/data/provider/api.dart';
import 'package:jantung_app/app/data/services/auth/repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    this.repository = AuthRepository(MyApi());
    return this;
  }

  final token = ''.obs;
  AuthRepository? repository;
  final user = User().obs;
  final box = GetStorage();
  static const String _jwtKey = 'Authentication-Token';

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
      if (JwtDecoder.isExpired(token.value)) {
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
    storeJwtToken(token.value);
    return data;
  }

  logout() async {
    var data = await repository?.logout();
    clearJwtToken();
    return data;
  }
}
