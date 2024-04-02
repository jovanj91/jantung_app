class Patient {
  int? patientId;
  String? patientName;
  String? patientDob;
  String? patientGender;
  String? checkResult;

  Patient({
    required this.patientId,
    required this.patientName,
    required this.patientDob,
    required this.patientGender,
    required this.checkResult,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    patientDob = json['dob'];
    patientGender = json['gender'];
    checkResult = json['check_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['dob'] = this.patientDob;
    data['gender'] = this.patientGender;
    data['check_result'] = this.checkResult;

    return data;
  }
}
