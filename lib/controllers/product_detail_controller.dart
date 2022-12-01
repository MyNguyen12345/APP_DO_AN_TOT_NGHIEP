// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:smartkit/models/product_detail_model.dart';
// import 'package:smartkit/models/product_model.dart';

// import '../Screen/HappyShopProductDetail.dart';
// import '../api_service/api_service.dart';

// class ProductDetailController extends GetxController {
//   var isloading = true.obs;
//   var productdetail = <ProductDetailModel>[].obs;

//   Future<void> fetchProductdetails({required int productId}) async {
//     var productsdetails = await APIService.fetchProductdetail(id: productId);
//     if (productsdetails != null) {
//       productdetail.value = productsdetails;
//     }
//   }
// }
