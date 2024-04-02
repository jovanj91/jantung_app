import 'dart:convert';

AppError appErrorFromJson(String str) => AppError.fromJson(json.decode(str));

String appErrorToJson(AppError data) => json.encode(data.toJson());

class AppError {
  AppError({
    this.errors,
  });

  String? errors;

  factory AppError.fromJson(Map<String, dynamic> json) => AppError(
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
      };

  String? getError() {
    return errors;
  }
}
