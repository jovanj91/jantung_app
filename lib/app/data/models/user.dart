class User {
  int? id;
  String? useremail;
  String? password;

  User({this.id, this.useremail, this.password});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['user_id'];
    this.useremail = json['email'];
    this.password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.id;
    data['email'] = this.useremail;
    data['password'] = this.password;
    return data;
  }
}
