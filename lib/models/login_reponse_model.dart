class LoginReponseModel {
  LoginReponseModel(
      {required this.phone, required this.token, required this.roleName});
  late final int phone;
  late final String token;
  late final String roleName;

  LoginReponseModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    token = json['token'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    _data['roleName'] = roleName;
    return _data;
  }
}
