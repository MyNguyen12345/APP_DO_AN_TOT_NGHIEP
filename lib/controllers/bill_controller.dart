import 'package:get/get.dart';
import 'package:smartkit/provider/bill_provider.dart';

class UpdateBillController extends GetxController with StateMixin<bool> {
  final provider = Get.put(UpdateBillProvider());
  Future<bool> updateBill(List<int> listProductId,
      List<int> listAmountBuy,
      String address,
      int payId,
      int userId,
      double priceTotal) async {
    final Response res = await provider.updateBill(listProductId, listAmountBuy, address, payId, userId, priceTotal);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(null, status: RxStatus.success());
      return true;
    }
  }
}
