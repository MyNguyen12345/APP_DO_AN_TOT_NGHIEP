import 'package:get/get.dart';
import 'package:smartkit/models/product_model.dart';
import 'package:smartkit/models/user_model.dart';
import 'package:smartkit/provider/user_provider.dart';

import '../api_service/api_service.dart';
import '../provider/product_model_provider.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  final provider = Get.put(UserProvider());
  Future<bool> fetchUser(int phone) async {
    final Response res = await provider.getUserModel(phone);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}

class UpdateAddressController extends GetxController with StateMixin<bool> {
  final provider = Get.put(UpdateAddressProvider());
  Future<bool> updateAddress(int userId, String address) async {
    final Response res = await provider.updateAddress(userId, address);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}
