import 'dart:ffi';

import 'package:get/get.dart';
import 'package:smartkit/models/cart_model.dart';
import 'package:smartkit/models/delete_model.dart';
import 'package:smartkit/models/login_model.dart';
import 'package:smartkit/models/login_reponse_model.dart';
import 'package:smartkit/Constant/api_url_constant.dart';

class AddProductCartProvider extends GetConnect {
  void onInit() {
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<bool>> addproduct(
      int userId, int productId, int amountProduct) async {
    final _body = {
      'productId': productId,
      'amountProduct': amountProduct,
    };
    return await post('cart/$userId', _body);
  }
}

class ListProductCartProvider extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder =
        (list) => List<CartModel>.from(list.map((x) => CartModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<List<CartModel>>> listcart(int userId) async {
    return await get('cart/$userId');
  }
}

class DeleteProductCartProvider extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder =null;
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<Null>> deleteCart(int cartId) async {
    return await delete('cart/detele/$cartId');
  }
}
