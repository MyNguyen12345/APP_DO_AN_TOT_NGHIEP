import 'package:get/get.dart';
import 'package:smartkit/models/product_model.dart';
import 'package:smartkit/provider/product_detail_provider.dart';

import '../api_service/api_service.dart';
import '../models/product_detail_model.dart';
import '../provider/product_model_provider.dart';

class ProductDetailController extends GetxController
    with StateMixin<List<ProductDetailModel>> {
  final provider = Get.put(ProductDetailProvider());
  Future<bool> getProductDetail(List<int> listProductId) async {
    final Response res = await provider.getProductDetail(listProductId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}