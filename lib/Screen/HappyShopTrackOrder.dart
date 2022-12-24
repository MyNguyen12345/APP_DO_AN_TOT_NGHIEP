import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopProductDetail.dart';
import 'package:smartkit/controllers/bill_controller.dart';
import 'package:smartkit/controllers/bill_status_controller.dart';
import 'package:sqflite/sql.dart';

import 'HappyShopCatgories.dart';
import 'HappyShopHome.dart';
import 'HappyShopOrderUser.dart';
import 'HappyShopUser.dart';

class HappyShopTreackOrder extends GetView<GetBillController> {
  final bool? appbar;
  HappyShopTreackOrder({Key? key, this.appbar}) : super(key: key);

  final storage = const FlutterSecureStorage();
  final GetBillStatusController getBillStatusController =
      Get.put(GetBillStatusController());
  final GetBillController getBillController = Get.put(GetBillController());

  final CancelBillController cancelBillController =
      Get.put(CancelBillController());

  // ScrollController controller = new ScrollController();
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;
  Future<void> listBill(int billStatusId) async {
    var userId = await storage.read(key: 'userId');
    await getBillController.getListBill(int.parse(userId!), billStatusId);
  }

  Future<void> cancelBill(int billId) async {
    await cancelBillController.cancelBill(billId, 8);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => GetBillController(),
    );
    listBill(1);
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HappyShopHome(),
          ),
        ).then((value) => value as bool);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Hóa đơn Mua",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              // category //
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Danh Mục",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          seeAll,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      onTap: () {
                        // Get.to(() => HappyShopCatogeryAll());
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: getBillStatusController.state!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: new ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://happyshop1233.herokuapp.com/" +
                                                    getBillStatusController
                                                        .state![index]
                                                        .billStatusIcon,
                                            fit: BoxFit.fill,
                                            width: 50,
                                            height: 50,
                                          ))),
                                ),
                              ),
                              Container(
                                child: Text(
                                  getBillStatusController
                                      .state![index].billStatusName,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          listBill(getBillStatusController
                              .state![index].billStatusId);
                        });
                  },
                ),
              ),
              Expanded(child: _showContent()),

              // New arrival for men's //
            ],
          )),
    );
  }

  _showContent() {
    return controller.obx((state) => ScreenTypeLayout(
          mobile: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: getBillController.state?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://happyshop1233.herokuapp.com/" +
                                                    getBillController
                                                        .state![index]
                                                        .userInfoDto
                                                        .avatar,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Text(
                                      getBillController
                                          .state![index].userInfoDto.username,
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Xem",
                                      style: TextStyle(color: Colors.pink),
                                    ),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.pink,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              onTap: (() {
                                Get.to(HappyShopUser(getBillController
                                    .state![index].userInfoDto.userId));
                              }),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: getBillController
                              .state![index].listBillDetail.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, indexDetail) {
                            return listItem(index, indexDetail);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Tổng tiền:",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getBillController.state![index].totalPrice
                                        .toString() +
                                    "  VNĐ",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  cancelBill(
                                      getBillController.state![index].billId);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0.0)),
                                    ),
                                    primary: Colors.transparent,
                                    padding: EdgeInsets.all(0.0)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: happyshopgradient,
                                  ),
                                  child: Container(
                                    height: 40.0,
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Đánh giá",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget listItem(int index, int indexDetail) {
    return controller.obx((state) => Card(
          elevation: 0.1,
          child: InkWell(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://happyshop1233.herokuapp.com/" +
                        getBillController.state![index]
                            .listBillDetail[indexDetail].product.avatar,
                    height: 70.0,
                    width: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  getBillController
                                      .state![index]
                                      .listBillDetail[indexDetail]
                                      .product
                                      .productName,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 46, 44, 44),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // cong tru
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Text(
                            " X " +
                                getBillController.state![index]
                                    .listBillDetail[indexDetail].amountBuy
                                    .toString(),
                            // style: Theme.of(context).textTheme.overline,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      getBillController.state![index]
                              .listBillDetail[indexDetail].product.priceProduct
                              .toString() +
                          " VNĐ",
                      style: TextStyle(
                          // decoration: TextDecoration.lineThrough,
                          letterSpacing: 0.7,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            splashColor: primary.withOpacity(0.2),
            onTap: () {},
          ),
        ));
  }

  // getDelivered(String dDate, String? cDate) {
  //   return cDate == null
  //       ? Flexible(
  //           flex: 1,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Expanded(
  //                   child: Divider(
  //                 thickness: 2,
  //                 color: dDate == null ? Colors.grey : happyshopcolor8,
  //               )),
  //               Column(
  //                 children: [
  //                   Text(
  //                     ORDER_DELIVERED,
  //                     style: TextStyle(fontSize: 8),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //                     child: Icon(
  //                       dDate == null
  //                           ? Icons.radio_button_unchecked
  //                           : Icons.radio_button_checked,
  //                       color: dDate == null ? Colors.grey : happyshopcolor8,
  //                     ),
  //                   ),
  //                   Text(
  //                     dDate,
  //                     style: TextStyle(fontSize: 8),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }

  // getCanceled(String cDate) {
  //   return cDate != null
  //       ? Flexible(
  //           flex: 1,
  //           child: Row(
  //             children: [
  //               Flexible(
  //                   flex: 1,
  //                   child: Divider(
  //                     thickness: 2,
  //                     color: Colors.red,
  //                   )),
  //               Column(
  //                 children: [
  //                   Text(
  //                     ORDER_CANCLED,
  //                     style: TextStyle(fontSize: 8),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //                     child: Icon(
  //                       Icons.radio_button_checked,
  //                       color: Colors.red[700],
  //                     ),
  //                   ),
  //                   Text(
  //                     cDate,
  //                     style: TextStyle(fontSize: 8),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }
}
