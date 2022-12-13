import 'package:get/get.dart';
import 'package:smartkit/provider/Bill_status_provider.dart';

import '../models/bill_status_model.dart';
class GetBillStatusController extends GetxController
    with StateMixin<List<BillStatusModel>> {
  final provider = Get.put(GetBillStatusProvider());
  void getBillStatus() async {
    final Response res = await provider.getBillStatus();
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    getBillStatus();
    super.onInit();
  }
}