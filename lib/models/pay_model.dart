class PayModel {
  PayModel({
    required this.payId,
    required this.payName,
  });
  late final int payId;
  late final String payName;
  
  PayModel.fromJson(Map<String, dynamic> json){
    payId = json['payId'];
    payName = json['payName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payId'] = payId;
    _data['payName'] = payName;
    return _data;
  }
}