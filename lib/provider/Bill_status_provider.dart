import 'package:get/get.dart';
import 'package:smartkit/models/bill_status_model.dart';

import '../Constant/api_url_constant.dart';

class GetBillStatusProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (list) => List<BillStatusModel>.from(
        list.map((x) => BillStatusModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<List<BillStatusModel>>> getBillStatus() async {
    return await get('bill/status');
  }
}