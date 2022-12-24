import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:multiple_images_picker/multiple_images_picker.dart';

import '../Constant/api_url_constant.dart';

class PostProvider {
  // @override
  // void onInit() {
  //   super.onInit();
  //   httpClient.baseUrl = APIADDRESS;
  // }

var dio = DIO.Dio();
  Future<DIO.Response> newPost(
      int userId,
      int categoryDetailId,
      String productName,
      String productStatus,
      String description,
      int amountProduct,
      double priceProduct,
      double priceDeposit,
      List<Asset> listImage,
      Asset avatar) async {
    FormData form = FormData({
      'user_id': userId,
      'post_status':"cho",
      'category_detail_id': categoryDetailId,
      'product_name': productName,
      'product_status': productStatus,
      'avatar': avatar,
      'description': description,
      'amount_product': amountProduct,
      'price_product': priceProduct,
      'price_deposit': priceDeposit,
      'list_image': listImage
    });
    return await dio.post('post', data: form); 
  }
}
