import 'package:get/get.dart';
import 'package:smartkit/Constant/api_url_constant.dart';
import 'package:smartkit/models/user_model.dart';
// import 'package:smartkit/models/product_detail_model.dart';
import 'package:smartkit/widget/Image_Slider.dart';

import '../models/product_model.dart';
// import 'package:smartkit/models/product_model.dart';

// import '../api_service/api_service.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (map) => UserModel.fromJson(map);
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<UserModel>> getUserModel(int phone) async {
    return await get('user/phone/$phone');
  }
}
