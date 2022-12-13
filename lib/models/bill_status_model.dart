class BillStatusModel {
  BillStatusModel({
    required this.billStatusId,
    required this.billStatusName,
    required this.billStatusIcon,
  });
  late final int billStatusId;
  late final String billStatusName;
  late final String billStatusIcon;
  
  BillStatusModel.fromJson(Map<String, dynamic> json){
    billStatusId = json['billStatusId'];
    billStatusName = json['billStatusName'];
    billStatusIcon = json['billStatusIcon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['billStatusId'] = billStatusId;
    _data['billStatusName'] = billStatusName;
    _data['billStatusIcon'] = billStatusIcon;
    return _data;
  }
}