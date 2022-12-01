// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// List<ProductDetailModel> productDetaiFromJson(String str) =>
//     List<ProductDetailModel>.from(
//         json.decode(str).map((x) => ProductDetailModel.fromJson(x)));

// // ProductDetailModel productDetaiFromJson(String str) =>
// //     ProductDetailModel.fromJson(json.decode(str));
// String productDetaiToJson(List<ProductDetailModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    required this.listImage,
  });

  int productId;
  int userId;
  int categoryDetailId;
  String productName;
  String productStatus;
  String avatar;
  String description;
  int amountProduct;
  double priceProduct;
  double priceDeposit;
  List<ListImage> listImage;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
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
        listImage: List<ListImage>.from(
            json["listImage"].map((x) => ListImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "userId": userId,
        "categoryDetailId": categoryDetailId,
        "productName": productName,
        "productStatus": productStatus,
        "avatar": avatar,
        "description": description,
        "amountProduct": amountProduct,
        "priceProduct": priceProduct,
        "priceDeposit": priceDeposit,
        "listImage": List<dynamic>.from(listImage.map((x) => x.toJson())),
      };
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
