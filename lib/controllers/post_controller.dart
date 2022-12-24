// import 'package:get/get.dart' ;
// import 'package:multiple_images_picker/multiple_images_picker.dart';
// import 'package:smartkit/provider/post_provider.dart';
// import 'package:dio/dio.dart' as DIO;


// class PostController extends GetxController
//     with StateMixin<bool> {
//   final provider = Get.put(PostProvider());
//   Future<bool> newPost(int userId,int categoryDetailId,String productName,String productStatus,String description,
//   int amountProduct,double priceProduct,double priceDeposit,List<Asset> listImage, Asset avatar ) async {
//     final Response res = await provider.newPost(userId,categoryDetailId,productName,productStatus,description,amountProduct,priceProduct,priceDeposit,listImage,avatar);
//     if (res.hasError) {
//       change(null, status: RxStatus.error(res.statusText));
//       return false;
//     } else {
//       change(res.body, status: RxStatus.success());
//       return true;
//     }
//   }

// }
