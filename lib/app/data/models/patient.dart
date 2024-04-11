class Patient {
  int? patientId;
  String? patientName;
  String? patientDob;
  int? patientAge;
  int? patientGender;

  Patient({
    this.patientId,
    this.patientName,
    this.patientDob,
    this.patientAge,
    this.patientGender,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    patientDob = json['patientDob'];
    patientAge = json['patientAge'];
    patientGender = json['patientGender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['patientAge'] = this.patientAge;
    data['patientDob'] = this.patientDob;
    data['patientGender'] = this.patientGender;

    return data;
  }
}
