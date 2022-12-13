import 'package:get/get.dart';
import 'package:smartkit/models/bill_model.dart';

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
      int userId) async {
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
    };
    print(_body);
    return  
    await post('bill', _body);
  }
}

class GetBillProvider extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder =
        (list) => List<BillModel>.from(list.map((x) => BillModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<List<BillModel>>> getListBill(int userId, int billStatusId) async {
    return await get('bill/$userId?billStatusId=$billStatusId');
  }
}

class GetBillProductSellProvider extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder =
        (list) => List<BillModel>.from(list.map((x) => BillModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<List<BillModel>>> getBillSell(int userId, int billStatusId) async {
    return await get('bill/product/$userId?billStatusId=$billStatusId');
  }
}

class CancelBillProvider extends GetConnect {
  void onInit() {
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<bool>> cancelBill(int billId, int billStatusId) async {
    return await post('bill/$billId?billStatusId=$billStatusId',null);
  }
}
