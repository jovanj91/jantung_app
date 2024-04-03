import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
import 'package:jantung_app/app/data/models/app_error.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';

const baseUrl = 'http://192.168.100.89:8080';

class MyApi extends GetConnect {
  login(email, password) async {
    AuthService auth = Get.find<AuthService>();
    try {
      final response = await post(
        '$baseUrl/login?include_auth_token',
        json.encode({"email": email, "password": password}),
      );
      print(response.body);
      if (response.isOk) {
        final Map<String, dynamic> jsonResponse = response.body;
        auth.token.value =
            jsonResponse['response']['user']['authentication_token'];
        auth.user.update((val) {
          val?.useremail = email;
          val?.password = password;
        });
        return response;
      } else if (response.statusCode == 400) {
        return AppError(errors: 'Wrong Password or Email');
      } else {
        return AppError(errors: 'Unexpected Error, please try again');
      }
    } catch (exception) {
      return AppError(errors: 'Unexpected Error');
    }
  }

  logout() async {
    try {
      final response = await post('$baseUrl/logout', "text/html");
      return response;
    } catch (e) {
      return AppError(errors: 'Unexpected Error');
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

  // Fetch Patient Data
  Future getPatient() async {
    AuthService auth = Get.find<AuthService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-Type': 'application/json', // Example header
    };
    try {
      final response = await get("$baseUrl/getPatientsData", headers: headers);
      if (response.status.hasError) {
        return AppError(errors: response.statusText);
      } else {
        return response.body['data'];
      }
    } catch (exception) {
      return AppError(errors: exception.toString());
    }
  }

  //Adding patient data
  Future addPatient(name, gender, dob) async {
    AuthService auth = Get.find<AuthService>();
    PatientService patient = Get.find<PatientService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-Type': 'application/json', // Example header
    };
    try {
      final response = await post(
        '$baseUrl/inputPatientData',
        headers: headers,
        json.encode({"name": name, "gender": gender, "dob": dob}),
      );
      print(response.body);
      if (response.isOk) {
        patient.patientData.update((val) {
          val?.patientName = name;
          val?.patientGender = gender;
          val?.patientDob = dob;
        });
        return response;
      } else {
        return AppError(errors: 'Failed to add Patient');
      }
    } catch (exception) {
      return AppError(errors: 'Unexpected Error');
    }
  }

  //Fetch patient history
  Future getPatientHistory() async {
    AuthService auth = Get.find<AuthService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-Type': 'application/json', // Example header
    };
    try {
      final response =
          await get("$baseUrl/getPatientHistory", headers: headers);
      if (response.status.hasError) {
        return AppError(errors: response.statusText);
      } else {
        return response.body['data'];
      }
    } catch (exception) {
      return AppError(errors: exception.toString());
    }
  }
}
