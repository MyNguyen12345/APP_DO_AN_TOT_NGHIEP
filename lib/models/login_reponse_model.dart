class LoginReponseModel {
  LoginReponseModel({
    required this.phone,
    required this.token,
  });
  late final int phone;
  late final String token;
  
  LoginReponseModel.fromJson(Map<String, dynamic> json){
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    _data['token'] = token;
    return _data;
  }
}