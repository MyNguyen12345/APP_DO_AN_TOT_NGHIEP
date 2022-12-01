import 'package:get/get.dart';
import 'package:smartkit/models/login_reponse_model.dart';
import 'package:smartkit/provider/login_provider.dart';

class LoginController extends GetxController
    with StateMixin<LoginReponseModel> {
  final provider = Get.put(LoginProvider());



  Future<bool> login(int phone, String password) async {
    final Response res = await provider.login(phone, password);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }

}
