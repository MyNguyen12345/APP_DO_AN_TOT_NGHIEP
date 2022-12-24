import 'package:get/get.dart';
import 'package:smartkit/provider/register_provider.dart';

class ForgotPasswordController extends GetxController
    with StateMixin<bool> {
  final provider = Get.put(ForgotPassWordProvider());
  Future<bool> findByPhone(int phone) async {
    final Response res = await provider.findByPhone(phone);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
   Future<bool> forgotPass(int phone,String password) async {
    final Response res = await provider.forgotPassword(phone,password);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}