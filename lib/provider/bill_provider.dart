import 'package:get/get.dart';

import '../Constant/api_url_constant.dart';

class UpdateBillProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<bool>> updateBill(
      List<int> listProductId,
      List<int> listAmountBuy,
      String address,
      int payId,
      int userId,
      double priceTotal) async {
    final bodyListId = [];
    final bodyAmount = [];
    for (int i = 0; i < listAmountBuy.length; i++) {
      var productId = {"productId": listProductId[i]};
      var amount = {"amountBuy": listAmountBuy[i]};
      bodyAmount.add(amount);
      bodyListId.add(productId);
    }
    final _body = {
      "listProductId": bodyListId,
      "listAmountBuy": bodyAmount,
      "addressBill": address,
      "payId": payId,
      "userId": userId,
      "priceTotal": priceTotal
    };
    print(_body);
    return  
    await post('bill', _body);
  }
}
