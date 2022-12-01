import 'package:get/get.dart';
import 'package:smartkit/Constant/api_url_constant.dart';
// import 'package:smartkit/models/product_detail_model.dart';
import 'package:smartkit/widget/Image_Slider.dart';

import '../models/product_model.dart';
// import 'package:smartkit/models/product_model.dart';

// import '../api_service/api_service.dart';

class ProductModelProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) => ProductModel.fromJson(map);
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<List<ProductModel>>> getProductsModel() async {
    return await get('product');
  }
   
    Future<Response<List<ProductModel>>> getProductsCategory(int categoryDetailId) async {
    return await get('product/list/cate?cateDetailId=$categoryDetailId');
  }

}
