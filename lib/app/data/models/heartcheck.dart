class HeartCheck {
  int? id;
  int? patientId;
  String? checkresult;
  String? videopath;
  String? checkedat;

  HeartCheck({
    this.id,
    this.patientId,
    this.checkresult,
    this.videopath,
    this.checkedat,
  });

  HeartCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    checkresult = json['checkResult'];
    videopath = json['videoPath'];
    checkedat = json['checkedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['checkResult'] = this.checkresult;
    data['videoPath'] = this.videopath;
    data['checkedAt'] = this.checkedat;

    return data;
  }

  void clearAllProperties() {
    id = null;
    patientId = null;
    checkedat = null;
    checkresult = null;
    videopath = null;
  }
}
