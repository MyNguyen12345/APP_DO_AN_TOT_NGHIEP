class DeleteModel {
  DeleteModel({
    required this.boolean,
  });
  late final bool boolean;
  
  DeleteModel.fromJson(Map<String, dynamic> json){
    boolean = json['boolean'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['boolean'] = boolean;
    return _data;
  }
}