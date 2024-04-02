import 'package:jantung_app/app/data/provider/api.dart';

class PatientRepository {
  final MyApi api;

  PatientRepository(this.api);

  getPatient() => api.getPatient();
}
