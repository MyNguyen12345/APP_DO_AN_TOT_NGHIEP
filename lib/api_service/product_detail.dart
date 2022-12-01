// // import 'dart:convert';

// import '../models/product_detail_model.dart';
// // import 'api_service.dart';
// import 'package:http/http.dart' as http;

// class ProductdetailID {
//   ProductdetailID({
//     required this.id,
//   });
//   int id;
// }

// class ProductdetailIDApi {
//   static var client = http.Client();
//   static Future<ProductDetailModel?> fetchProductdetail(int pagram) async {
//     var response = await client
//         .get(Uri.parse('https://datn123.herokuapp.com/product/$pagram'));
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       return productDetaiFromJson(jsonString);
//     } else {
//       return null;
//     }
//   }
// }
