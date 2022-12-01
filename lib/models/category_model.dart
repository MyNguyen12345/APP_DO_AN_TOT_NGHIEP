class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryDetail,
  });
  late final int categoryId;
  late final String categoryName;
  late final String categoryIcon;
  late final List<CategoryDetail> categoryDetail;
  
  CategoryModel.fromJson(Map<String, dynamic> json){
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryIcon = json['categoryIcon'];
    categoryDetail = List.from(json['categoryDetail']).map((e)=>CategoryDetail.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categoryId'] = categoryId;
    _data['categoryName'] = categoryName;
    _data['categoryIcon'] = categoryIcon;
    _data['categoryDetail'] = categoryDetail.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CategoryDetail {
  CategoryDetail({
    required this.categoryDetailIcon,
    required this.categoryDetailId,
    required this.categoryDetailName,
    required this.categoryId,
  });
  late final String categoryDetailIcon;
  late final int categoryDetailId;
  late final String categoryDetailName;
  late final int categoryId;
  
  CategoryDetail.fromJson(Map<String, dynamic> json){
    categoryDetailIcon = json['categoryDetailIcon'];
    categoryDetailId = json['categoryDetailId'];
    categoryDetailName = json['categoryDetailName'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categoryDetailIcon'] = categoryDetailIcon;
    _data['categoryDetailId'] = categoryDetailId;
    _data['categoryDetailName'] = categoryDetailName;
    _data['categoryId'] = categoryId;
    return _data;
  }
}