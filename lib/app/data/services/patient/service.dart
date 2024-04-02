import 'package:jantung_app/app/data/models/patient.dart';
import 'package:jantung_app/app/data/provider/api.dart';
import 'package:jantung_app/app/data/services/patient/repository.dart';
import 'package:jantung_app/routes/app_pages.dart';

import 'package:get/get.dart';

class PatientService extends GetxService {
  Future<PatientService> init() async {
    this.repository = PatientRepository(MyApi());
    return this;
  }

  PatientRepository? repository;

  getPatient() async {
    var data = await repository?.getPatient();
    return data;
  }
}
