import 'package:get/get.dart';
import 'package:smartkit/Constant/api_url_constant.dart';
import 'package:smartkit/models/pay_model.dart';
// import 'package:smartkit/models/product_detail_model.dart';
import 'package:smartkit/widget/Image_Slider.dart';

import '../models/product_detail_model.dart';
import '../models/product_model.dart';
// import 'package:smartkit/models/product_model.dart';

// import '../api_service/api_service.dart';

class PayProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (list) => List<PayModel>.from(list.map((x) => PayModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<List<PayModel>>> getListPay() async {
   
    return await get('pay');
  }
}
