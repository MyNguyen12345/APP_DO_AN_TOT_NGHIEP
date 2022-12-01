import 'package:get/get.dart';
import 'package:smartkit/models/login_model.dart';
import 'package:smartkit/models/login_reponse_model.dart';
import 'package:smartkit/Constant/api_url_constant.dart';
class LoginProvider extends GetConnect {
  void onInit() {
    httpClient.defaultDecoder = (map) => LoginReponseModel.fromJson(map);
     httpClient.baseUrl = APIADDRESS;
  }

  Future<Response<LoginReponseModel>> login(int phone, String password) async {
    final _body = {
      'phone': phone,
      'password': password,
    };
    return await post('login', _body);
  }
}
