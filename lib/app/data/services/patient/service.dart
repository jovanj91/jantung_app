import 'package:jantung_app/app/data/models/heartcheck.dart';
import 'package:jantung_app/app/data/models/patient.dart';
import 'package:jantung_app/app/data/provider/api.dart';
import 'package:jantung_app/app/data/services/patient/repository.dart';

import 'package:get/get.dart';

class PatientService extends GetxService {
  Future<PatientService> init() async {
    this.repository = PatientRepository(MyApi());
    return this;
  }

  PatientRepository? repository;
  final patientData = Patient().obs;
  final patientHistory = HeartCheck().obs;

  getPatient() async {
    var data = await repository?.getPatient();
    return data;
  }

  addPatient(name, gender, dob) async {
    var data = await repository?.addPatient(name, gender, dob);
    return data;
  }

  getPatientHistory(patientId) async {
    var data = await repository?.getPatientHistory(patientId);
    return data;
  }
}
