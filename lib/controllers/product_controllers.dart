import 'package:get/get.dart';
import 'package:smartkit/models/product_model.dart';

import '../api_service/api_service.dart';
import '../provider/product_model_provider.dart';

class ProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final provider = Get.put(ProductModelProvider());
  Future<bool> fetchList(int phone) async {
    final Response res = await provider.getProductsModel(phone);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }

  // @override
  // void onInit() {
  //   fetchList();
  //   super.onInit();
  // }
}

class ProductCategoryController extends GetxController
    with StateMixin<List<ProductModel>> {
  final provider = Get.put(ProductModelProvider());
  Future<bool> productsCategoryDetail(int categoryDetailId) async {
    final Response res = await provider.getProductsCategory(categoryDetailId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
class GetProductUserIdController extends GetxController
    with StateMixin<List<ProductModel>> {
  final provider = Get.put(ProductModelProvider());
  Future<bool> getProductUserId(int userId) async {
    final Response res = await provider.getProductsUserId(userId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
class GetProductUserIdStatusController extends GetxController
    with StateMixin<List<ProductModel>> {
  final provider = Get.put(ProductModelProvider());
  Future<bool> listProductStatus(int userId) async {
    final Response res = await provider.listProductStatus(userId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
