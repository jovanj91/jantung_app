import 'package:jantung_app/app/data/provider/api.dart';

class AuthRepository {
  final MyApi api;

  AuthRepository(this.api);

  login(email, password) => api.login(email, password);
}
