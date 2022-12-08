import 'package:get/get.dart';
import 'package:smartkit/models/pay_model.dart';
import 'package:smartkit/models/product_model.dart';
import 'package:smartkit/provider/pay_provider.dart';

import '../api_service/api_service.dart';
import '../provider/product_model_provider.dart';

class PayController extends GetxController
    with StateMixin<List<PayModel>> {
  final provider = Get.put(PayProvider());
  Future<bool> listPay() async {
    final Response res = await provider.getListPay();
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }

}
