import 'package:jantung_app/app/data/models/app_error.dart';

abstract class VerifyError {
  static verify(data) {
    if (data.runtimeType == AppError) {
      return true;
    } else
      return false;
  }
}
