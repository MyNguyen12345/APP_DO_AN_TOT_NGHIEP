import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/product_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<ProductModel>?> fetchProduct() async {
    var response =
        await client.get(Uri.parse('https://datn123.herokuapp.com/product'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }
}
