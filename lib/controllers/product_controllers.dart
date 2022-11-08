import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../Constant/api_url_constant.dart';
class ProductController extends GetxController{
  Future getProducts() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: url,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret);

    // Get data using the "products" endpoint
    var products = await wooCommerceAPI.getAsync("products").obs;
    return products;
  }
}