import 'package:get/get.dart';

import '../Constant/api_url_constant.dart';

class ForgotPassWordProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<bool>> findByPhone(int phone) async {
    return await get('register/$phone');
  }

   Future<Response<bool>> forgotPassword(int phone, String password) async {
    var formdata=FormData({ 'password':password}
     
    );
    return await post('register/pass/$phone',formdata);
  }
}