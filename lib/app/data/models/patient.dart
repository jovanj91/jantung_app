class Patient {
  int? patientId;
  String? patientName;
  String? patientDob;
  String? patientGender;

  Patient({
    this.patientId,
    this.patientName,
    this.patientDob,
    this.patientGender,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    patientDob = json['dob'];
    patientGender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['dob'] = this.patientDob;
    data['gender'] = this.patientGender;

    return data;
  }
}
