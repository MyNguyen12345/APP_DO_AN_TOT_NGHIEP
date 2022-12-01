import 'package:get/get.dart';
import 'package:smartkit/models/category_model.dart';

import '../Constant/api_url_constant.dart';

class CategoryProvier extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder = (list) =>
        List<CategoryModel>.from(list.map((x) => CategoryModel.fromJson(x)));
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<List<CategoryModel>>> listCategory() async {
    return await get('category');
  }
}

class CategoryIdProvier extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder = (map) => CategoryModel.fromJson(map);
    httpClient.baseUrl = APIADDRESS;
    super.onInit();
  }

  Future<Response<List<CategoryModel>>> listCategoryId(int categoryId) async {
    return await get('category/detail/categoryId?$categoryId');
  }
}
