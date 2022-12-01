// // import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// // import '../config/api_config.dart';
// import '../models/product_detail_model.dart';
// import '../models/product_model.dart';
// import 'dart:convert';

// class APIService {
//   static var client = http.Client();

//   static Future<List<ProductModel>?> fetchProduct() async {
//     var response =
//         await client.get(Uri.parse('https://datn123.herokuapp.com/product'));
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       return productFromJson(jsonString);
//     } else {
//       return null;
//     }
//   }

//   static Future<List<ProductDetailModel>?> fetchProductdetail(
//       {required int id}) async {
//     var response = await client
//         .get(Uri.parse('https://datn123.herokuapp.com/product/${id}'));

//     print(response.body);
//     if (response.statusCode == 200) {
//       // // var body = json.decode(response.body).cast<Map<String, dynamic>>();
//       // final map = response.body as Map<String, dynamic>;
//       // final body = ProductDetailModel.fromJson(Map<String, dynamic>.from(map));
//       // return body;
//       var jsonString = response.body;
//       return productDetaiFromJson(jsonString);
//     } else {
//       return null;
//     }
//   }
// }
