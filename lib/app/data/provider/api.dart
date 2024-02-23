import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
import 'package:jantung_app/app/data/models/app_error.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';

const baseUrl = 'http://192.168.1.40:8080';

class MyApi extends GetConnect {
  login(email, password) async {
    AuthService auth = Get.find<AuthService>();

    final response = await post(
      '$baseUrl/login',
      json.encode({"email": email, "password": password}),
      decoder: (res) {
        // if (res['token'] != null && res['token'] != '') {
        //    auth.token.value = res['token'];
        // }

        return res;
      },
    );

    if (response.statusCode == 201) {
      auth.user.update((val) {
        val?.useremail = email;
        val?.password = password;
      });
      auth.jwtToken.value = response.body['token'];
      return auth.user;
    } else if (response.statusCode == 500) {
      return AppError(errors: 'Unexpected Error');
    } else {
      return AppError(errors: 'Wrong Email or Password');
    }
  }

  processVideo(File videoFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/preprocessing'),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'video',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: videoFile.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    final startTime = DateTime.now();
    var res = await request.send();
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final uploadSpeed =
        (videoFile.lengthSync() / 1024) / duration.inSeconds; // Speed in Kbps
    print('Upload Speed: ${uploadSpeed.toStringAsFixed(2)} Kbps');
    http.Response response = await http.Response.fromStream(res);
  }

  // Future<http.Response> authenticatedRequest(
  //   String endpoint, {
  //   Map<String, String>? headers,
  //   dynamic body,
  //   String method = 'GET',
  // }) async {
  //   final url = Uri.parse('$baseUrl/$endpoint');
  //   if (method == 'GET') {
  //     return http.get(url, headers: getHeaders());
  //   } else if (method == 'POST') {
  //     return http.post(url, headers: getHeaders(), body: body);
  //   } else if (method == 'PUT') {
  //     return http.put(url, headers: getHeaders(), body: body);
  //   } else if (method == 'DELETE') {
  //     return http.delete(url, headers: getHeaders());
  //   } else {
  //     throw Exception('Unsupported HTTP method');
  //   }
  // }
}
