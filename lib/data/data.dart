import 'package:get/get.dart';
import 'package:smartkit/models/product_detail_model.dart';

class Data extends GetxController {
  late List<int>? listProductId = [];
  late List<int>? listAmount = [];
  late double? totalPrice = 0.0;
  late double? promotion = 0.0;
  late double? price = 0.0;
  var address ="".obs;
}
