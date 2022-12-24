import 'package:get/get.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:smartkit/models/product_detail_model.dart';
import 'package:dio/dio.dart' as DIO;

class Data extends GetxController {
  late List<int>? listProductId = [];
  late List<int>? listAmount = [];
  late double? totalPrice = 0.0;
  late double? promotion = 0.0;
  late double? price = 0.0;
  late int phone = 0;
  var address = "".obs;
  late int categoryDetailId = 0;
  List<DIO.MultipartFile> listImage = [];
  List<Asset> images = [];
}
