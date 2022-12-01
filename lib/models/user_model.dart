class UserModel {
  UserModel({
    required this.userId,
    required this.avatar,
    required this.username,
    required this.gender,
    required this.address,
    required this.birthday,
    required this.dateJoin,
    required this.accountStatus,
    required this.phone,
  });
  late final int userId;
  late final String avatar;
  late final String username;
  late final String gender;
  late final String address;
  late final String birthday;
  late final String dateJoin;
  late final String accountStatus;
  late final int phone;
  
  UserModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    avatar = json['avatar'];
    username = json['username'];
    gender = json['gender'];
    address = json['address'];
    birthday = json['birthday'];
    dateJoin = json['dateJoin'];
    accountStatus = json['accountStatus'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['avatar'] = avatar;
    _data['username'] = username;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['birthday'] = birthday;
    _data['dateJoin'] = dateJoin;
    _data['accountStatus'] = accountStatus;
    _data['phone'] = phone;
    return _data;
  }
}