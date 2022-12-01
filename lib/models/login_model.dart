class LoginModel {
  LoginModel({
    required this.phone,
    required this.password,
  });
  late final int phone;
  late final String password;
  
  LoginModel.fromJson(Map<String, dynamic> json){
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    _data['password'] = password;
    return _data;
  }
}