import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jantung_app/app/data/models/app_error.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';

const baseUrl = 'http://192.168.100.89:8080';

class MyApi extends GetConnect {
  login(email, password) async {
    AuthService auth = Get.find<AuthService>();
    try {
      var url = Uri.parse('$baseUrl/login?include_auth_token');
      final response = await http.post(url,
          body: json.encode({"email": email, "password": password}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(response.body);
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
      print(exception.toString());

      return AppError(errors: exception.toString());
    }
  }

  logout() async {
    try {
      var url = Uri.parse('$baseUrl/logout');
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'});
      return response;
    } catch (e) {
      return AppError(errors: 'Unexpected Error');
    }
  }

  processVideo(File videoFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
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

  Future detectEchocardiography(File videoFile, patientId) async {
    AuthService auth = Get.find<AuthService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-type': 'multipart/form-data', // Example header
    };
    try {
      var url = Uri.parse('$baseUrl/detectEchocardiography');
      var request = http.MultipartRequest(
        'POST',
        url,
      );

      request.files.add(
        http.MultipartFile(
          'video',
          videoFile.readAsBytes().asStream(),
          videoFile.lengthSync(),
          filename: videoFile.path.split('/').last,
        ),
      );
      request.headers.addAll(headers);
      request.fields['patient_id'] = patientId.toString();
      print('1');
      var response = await request.send();
      if (response.statusCode >= 200) {
        return response;
      } else {
        return AppError(errors: 'Failed to check heart');
      }
    } catch (exception) {
      return AppError(errors: exception.toString());
    }
  }

  // Fetch Patient Data
  Future getPatient() async {
    AuthService auth = Get.find<AuthService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-Type': 'application/json', // Example header
    };
    try {
      var url = Uri.parse('$baseUrl/getPatientsData');
      final response = await http.get(url, headers: headers);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (response.statusCode > 400) {
        return AppError(errors: 'Failed to get data');
      } else {
        return jsonResponse['data'];
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
      var url = Uri.parse('$baseUrl/inputPatientData');
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({"name": name, "gender": gender, "dob": dob}),
      );

      if (response.statusCode >= 200) {
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
  Future getPatientHistory(patientId) async {
    AuthService auth = Get.find<AuthService>();
    final Map<String, String> headers = {
      'Authentication-Token': auth.token.value,
      'Content-Type': 'application/json', // Example header
    };
    try {
      var url = Uri.parse('$baseUrl/getPatientHistory?patient_id=$patientId');
      final response = await http.get(url, headers: headers);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        return AppError(errors: 'Failed to load data');
      } else {
        return jsonResponse['data'];
      }
    } catch (exception) {
      return AppError(errors: exception.toString());
    }
  }
}
