import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Screen/HappyShopHome.dart';
import 'package:smartkit/controllers/user_controller.dart';
import 'package:smartkit/models/user_model.dart';

import '../Helper/HappyShopColor.dart';
import '../controllers/add_product_cart.dart';
import '../controllers/product_controllers.dart';
import 'HappyShopProductDetail.dart';

class HappyShopMyShop extends GetView<GetProductUserIdController> {
  HappyShopMyShop({Key? key, this.appbar}) : super(key: key);
  final bool? appbar;
  final GetUserIdController getUserIdController =
      Get.put(GetUserIdController());
  final GetProductUserIdController getProductUserIdController =
      Get.put(GetProductUserIdController());
  final storage = const FlutterSecureStorage();

  Future<void> getUserId() async {
    var userId = await storage.read(key: 'userId');
    await getUserIdController.fetchUserId(int.parse(userId!));
    await getProductUserIdController.getProductUserId(int.parse(userId));
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

    return Scaffold(
        appBar: getAppBar("My Shop", context),
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
                                  imageUrl:
                                      "https://happyshop1233.herokuapp.com/" +
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
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 15),
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
                                    Icon(
                                      Icons.phone,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Text(
                                      "0" +
                                          getUserIdController.state!.phone
                                              .toString(),
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
                      child: controller.obx((state) => GridView.count(
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
                                child: ItemCardShop(
                                  voucher: getProductUserIdController
                                      .state![index].priceDeposit
                                      .toInt(),
                                  status: getProductUserIdController
                                      .state![index].productStatus,
                                  imagurl:
                                      "https://happyshop1233.herokuapp.com/" +
                                          getProductUserIdController
                                              .state![index].avatar,
                                  itemname: getProductUserIdController
                                      .state![index].productName,
                                  price: getProductUserIdController
                                      .state![index].priceProduct,
                                  rating: getProductUserIdController
                                      .state![index].rating,
                                  postStatus: state![index].postStatus,
                                  shadow: false,
                                ),
                              );
                            },
                          )))),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HappyShopHome()),
          );
        }),
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

class ItemCardShop extends StatefulWidget {
  const ItemCardShop({
    Key? key,
    this.imagurl,
    this.rating,
    this.itemname,
    this.price,
    this.shadow,
    this.status,
    this.voucher,
    this.postStatus,
  }) : super(key: key);

  final String? imagurl, itemname;
  final bool? shadow;
  final double? rating;
  final double? price;
  final String? status, postStatus;
  final int? voucher;

  @override
  _ItemCardStateShop createState() => _ItemCardStateShop();
}

class _ItemCardStateShop extends State<ItemCardShop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 100,
      decoration: widget.shadow!
          ? BoxDecoration(
              boxShadow: [BoxShadow(color: happyshopcolor5, blurRadius: 10)],
            )
          : null,
      child: Card(
        elevation: 0.2,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: widget.imagurl!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 10,
                            ),
                            Text(
                              widget.rating!.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(letterSpacing: 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 60,
              // ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 15, 7),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              widget.status!.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .overline!
                                  .copyWith(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 16.0,
                                      letterSpacing: 0.5),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.voucher!.toString() + '%',
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(
                                    color: Color.fromARGB(255, 250, 51, 20),
                                    fontSize: 16.0,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold),

                            maxLines: 1,

                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.itemname!,
                        style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 0.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(" " + " " + widget.price!.toString(),
                        style: TextStyle(color: primary)),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(widget.postStatus!,
                        style: TextStyle(
                          color: primary,
                        )),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
