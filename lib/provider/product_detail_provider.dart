import 'package:get/get.dart';
import 'package:smartkit/Constant/api_url_constant.dart';
// import 'package:smartkit/models/product_detail_model.dart';
import 'package:smartkit/widget/Image_Slider.dart';

import '../models/product_detail_model.dart';
import '../models/product_model.dart';
// import 'package:smartkit/models/product_model.dart';

// import '../api_service/api_service.dart';

class ProductDetailProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (list) => List<ProductDetailModel>.from(
        list.map((x) => ProductDetailModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<List<ProductDetailModel>>> getProductDetail(
      List<int> listproductId) async {
    final _body = [];
    for (int i = 0; i < listproductId.length; i++) {
      var body = {"productId": listproductId[i]};
      _body.add(body);
    }
    print(_body);
    return await post('product/listId', _body);
  }
}
