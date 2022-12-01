import 'package:smartkit/models/category_model.dart';
import 'package:get/get.dart';
import 'package:smartkit/provider/category_provider.dart';

class CategoryController extends GetxController
    with StateMixin<List<CategoryModel>> {
  final provider = Get.put(CategoryProvier());
  void fetchListCategory() async {
    final Response res = await provider.listCategory();
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    fetchListCategory();
    super.onInit();
  }
}

class CategoryIdController extends GetxController
    with StateMixin<CategoryModel> {
  final provider = Get.put(CategoryIdProvier());
  Future<bool> fetchListCategoryId(int categoryId) async {
    final Response res = await provider.listCategoryId(categoryId);
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
      return false;
    } else {
      change(res.body, status: RxStatus.success());
      return true;
    }
  }
}
