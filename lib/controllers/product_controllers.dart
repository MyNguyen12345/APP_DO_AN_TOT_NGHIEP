import 'package:get/get.dart';
import 'package:smartkit/models/product_model.dart';

import '../api_service/api_service.dart';

class ProductController extends GetxController {
  var isloading = true.obs;
  var productList = <ProductModel>[].obs;
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    var products = await APIService.fetchProduct();
    if (products != null) {
      productList.value = products;
    }
  }
}
