class HeartCheck {
  int? id;
  int? patientId;
  int? age;
  String? checkresult;
  String? videopath;
  String? checkedat;

  HeartCheck({
    this.id,
    this.patientId,
    this.age,
    this.checkresult,
    this.videopath,
    this.checkedat,
  });

  HeartCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    age = json['age'];
    checkresult = json['checkResult'];
    videopath = json['videoPath'];
    checkedat = json['checkedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['age'] = this.age;
    data['checkResult'] = this.checkresult;
    data['videoPath'] = this.videopath;
    data['checkedAt'] = this.checkedat;

    return data;
  }
}
