import 'package:get/get.dart';
import 'package:smartkit/provider/bill_provider.dart';

import '../models/bill_model.dart';

class UpdateBillController extends GetxController with StateMixin<bool> {
  final provider = Get.put(UpdateBillProvider());
  Future<bool> updateBill(List<int> listProductId, List<int> listAmountBuy,
      String address, int payId, int userId) async {
    final Response res = await provider.updateBill(
        listProductId, listAmountBuy, address, payId, userId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}

class GetBillController extends GetxController
    with StateMixin<List<BillModel>> {
  final provider = Get.put(GetBillProvider());
  Future<bool> getListBill(int userId, int billStatusId) async {
    final Response res = await provider.getListBill(userId, billStatusId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
class GetBillProductSellController extends GetxController
    with StateMixin<List<BillModel>> {
  final provider = Get.put(GetBillProductSellProvider());
  Future<bool> getBillSell(int userId, int billStatusId) async {
    final Response res = await provider.getBillSell(userId, billStatusId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
class CancelBillController extends GetxController
    with StateMixin<bool> {
  final provider = Get.put(CancelBillProvider());
  Future<bool> cancelBill(int billId, int billStatusId) async {
    final Response res = await provider.cancelBill(billId, billStatusId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}

