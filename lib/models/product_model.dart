import 'dart:convert';

import 'package:smartkit/models/product_detail_model.dart';

// List<ProductModel> productFromJson(String str) => List<ProductModel>.from(
//     json.decode(str).map((x) => ProductModel.fromJson(x)));

// String productToJson(List<ProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
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
    required this.listImage,
    required this.rating,
    required this.userRating,
    required this.postStatus
  });

  int productId;
  int userId;
  int categoryDetailId;
  String productName;
  String productStatus;
  String avatar;
  String description;
  String postStatus;
  int amountProduct;
  double priceProduct;
  double priceDeposit;
  double rating;
  int userRating;
  List<ListImage> listImage;
  static List<ProductModel> fromJson(dynamic data) {
    final _list = <ProductModel>[];
    for (var json in data) {
      _list.add(ProductModel(
        productId: json["productId"],
        userId: json["userId"],
        categoryDetailId: json["categoryDetailId"],
        productName: json["productName"],
        productStatus: json["productStatus"],
        avatar: json["avatar"],
        description: json["description"],
        amountProduct: json["amountProduct"],
        priceProduct: json["priceProduct"],
        priceDeposit: json["priceDeposit"],
        rating: json["rating"],
        userRating: json["userRating"],
        postStatus: json["postStatus"],
        listImage: List<ListImage>.from(
            json["listImage"].map((x) => ListImage.fromJson(x))),
      ));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    data['categoryDetailId'] = this.categoryDetailId;
    data['productName'] = this.productName;
    data['productStatus'] = this.productStatus;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    data['amountProduct'] = this.amountProduct;
    data['priceProduct'] = this.priceProduct;
    data['description'] = this.description;
    data['priceDeposit'] = this.priceDeposit;
    data['userRating'] = this.userRating;
    data['rating'] = this.rating;
     data['postStatus'] = this.postStatus;
    data['listImage'] = List<dynamic>.from(listImage.map((x) => x.toJson()));
    return data;
  }

  void add(ProductDetailModel productDetailModel) {}
}

class ListImage {
  ListImage({
    required this.imageId,
    required this.imageUrl,
  });

  int imageId;
  String imageUrl;

  factory ListImage.fromJson(Map<String, dynamic> json) => ListImage(
        imageId: json["imageId"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "imageId": imageId,
        "imageUrl": imageUrl,
      };
}
