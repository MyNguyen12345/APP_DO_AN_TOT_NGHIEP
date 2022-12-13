import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/controllers/user_controller.dart';
import 'package:smartkit/models/user_model.dart';

import '../Helper/HappyShopColor.dart';
import '../controllers/add_product_cart.dart';
import '../controllers/product_controllers.dart';
import 'HappyShopHomeTab.dart';
import 'HappyShopProductDetail.dart';

class HappyShopUser extends GetView<GetProductUserIdController> {
  HappyShopUser(this.userId, {Key? key}) : super(key: key);
  final int userId;
  final GetUserIdController getUserIdController =
      Get.put(GetUserIdController());
  final GetProductUserIdController getProductUserIdController =
      Get.put(GetProductUserIdController());
  final storage = const FlutterSecureStorage();

  Future<void> getUserId() async {
    await getUserIdController.fetchUserId(userId);
    await getProductUserIdController.getProductUserId(userId);
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => GetUserIdController(),
    );
     Get.lazyPut(
      () => GetProductUserIdController(),
    );
    getUserId();

    return  Scaffold(
        appBar: getAppBar("User Shop", context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              controller.obx((state) => InkWell(
                child: Container(
                  height: 130,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(97, 7, 197, 235)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: "https://happyshop1233.herokuapp.com/" +
                                  getUserIdController.state!.avatar,
                              height: 70,
                              width: 70,
                              fit: BoxFit.fill,
                            )),
                        onTap: () {
                          print("bam duoc");
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getUserIdController.state!.username,
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 15),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                Text(
                                  " (" + "120" + ")",
                                  // style: Theme.of(context).textTheme.overline,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 250,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 15,
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập tên vật phẩm',
                                    hintStyle: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // onTap: (() {
                //   Get.to(HappyShopUser());
                // }),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ScreenTypeLayout(
                  mobile: Container(
                    //                   controller.obx(
                    // (state) => ListView.separated(
                    child: controller.obx((state) =>  GridView.count(
                        padding: EdgeInsets.only(top: 5),
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 0.7,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          getProductUserIdController.state!.length,
                          (index) {
                            return InkWell(
                              onTap: () => Get.to(
                                HappyShopProductDetail(
                                  productModel: state![index],
                                ),
                              ),
                              child: ItemCard(
                                voucher: getProductUserIdController
                                    .state![index].priceDeposit
                                    .toInt(),
                                status: getProductUserIdController
                                    .state![index].productStatus,
                                imagurl:
                                    "https://happyshop1233.herokuapp.com/" +
                                        getProductUserIdController.state![index].avatar,
                                itemname:
                                    getProductUserIdController.state![index].productName,
                                price: getProductUserIdController
                                    .state![index].priceProduct,
                                rating: getProductUserIdController.state![index].rating,
                                shadow: false,
                              ),
                            );
                          },
                        )
                        ))
                        
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

getAppBar(String title, BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: primary),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: primary,
      ),
    ),
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    elevation: 5,
  );
}
