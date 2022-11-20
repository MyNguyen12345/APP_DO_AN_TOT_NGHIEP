import 'dart:convert';

List<ProductModel> productFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  });

  int productId;
  int userId;
  int categoryDetailId;
  String productName;
  String productStatus;
  String avatar;
  String description;
  int amountProduct;
  int priceProduct;
  int priceDeposit;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
      };
}
