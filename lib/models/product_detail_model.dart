class ProductDetailModel {
  ProductDetailModel({
    required this.productId,
    required this.userId,
    required this.categoryDetailId,
    required this.productName,
    required this.productStatus,
    required this.avatar,
    required this.description,
    required this.amountProduct,
    required this.priceProduct,
    required this.priceDeposit,
    required this.rating,
    required this.userRating,
    required this.listImage,
  });
  late final int productId;
  late final int userId;
  late final int categoryDetailId;
  late final String productName;
  late final String productStatus;
  late final String avatar;
  late final String description;
  late final int amountProduct;
  late final double priceProduct;
  late final double priceDeposit;
  late final double rating;
  late final int userRating;
  late final List<ListImage> listImage;
  
  ProductDetailModel.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    userId = json['userId'];
    categoryDetailId = json['categoryDetailId'];
    productName = json['productName'];
    productStatus = json['productStatus'];
    avatar = json['avatar'];
    description = json['description'];
    amountProduct = json['amountProduct'];
    priceProduct = json['priceProduct'];
    priceDeposit = json['priceDeposit'];
    rating = json['rating'];
    userRating = json['userRating'];
    listImage = List.from(json['listImage']).map((e)=>ListImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['userId'] = userId;
    _data['categoryDetailId'] = categoryDetailId;
    _data['productName'] = productName;
    _data['productStatus'] = productStatus;
    _data['avatar'] = avatar;
    _data['description'] = description;
    _data['amountProduct'] = amountProduct;
    _data['priceProduct'] = priceProduct;
    _data['priceDeposit'] = priceDeposit;
    _data['rating'] = rating;
    _data['userRating'] = userRating;
    _data['listImage'] = listImage.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListImage {
  ListImage({
    required this.imageId,
    required this.imageUrl,
  });
  late final int imageId;
  late final String imageUrl;
  
  ListImage.fromJson(Map<String, dynamic> json){
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageId'] = imageId;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}