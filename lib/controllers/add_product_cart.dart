import 'dart:ffi';

import 'package:get/get.dart';
import 'package:smartkit/models/cart_model.dart';
import 'package:smartkit/models/delete_model.dart';
import 'package:smartkit/models/login_reponse_model.dart';
import 'package:smartkit/provider/add_product_cart.dart';
import 'package:smartkit/provider/login_provider.dart';

class AddProductCartController extends GetxController with StateMixin<bool> {
  final provider = Get.put(AddProductCartProvider());
  Future<bool> addProduct(int userId, int productId, int amountProduct) async {
    final Response res =
        await provider.addproduct(userId, productId, amountProduct);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}

class GetProductCartController extends GetxController
    with StateMixin<List<CartModel>> {
  final provider = Get.put(ListProductCartProvider());

  Future<bool> listCart(int userId) async {
    final Response res = await provider.listcart(userId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}

class DeleteProductCartController extends GetxController with StateMixin<bool> {
  final provider = Get.put(DeleteProductCartProvider());

  Future<bool> deleteCart(int cartId) async {
    final Response res = await provider.deleteCart(cartId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}
