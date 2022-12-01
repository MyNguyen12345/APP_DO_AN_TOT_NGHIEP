import 'package:get/get.dart';
import 'package:smartkit/models/product_model.dart';
import 'package:smartkit/models/user_model.dart';
import 'package:smartkit/provider/user_provider.dart';

import '../api_service/api_service.dart';
import '../provider/product_model_provider.dart';

class UserController extends GetxController
    with StateMixin<UserModel> {
  final provider = Get.put(UserProvider());
  void fetchUser(int phone) async {
    final Response res = await provider.getUserModel(phone);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
    }
  }

  // @override
  // void onInit() {
  //   fetchList();
  //   super.onInit();
  // }
}
