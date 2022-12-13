import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/controllers/add_product_cart.dart';
import 'package:smartkit/controllers/product_detail_controller.dart';
import 'package:smartkit/desktop/detailproductdesktop.dart';
import 'package:smartkit/models/product_model.dart';
import '../api_service/api_service.dart';
import '../controllers/product_controllers.dart';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/product_detail_model.dart';
import 'HappyShopCart.dart';
import 'HappyShopProductPriview.dart';
import 'dart:convert';

class AddcouterprocutController extends GetxController {
  var count = 0.obs;
  RxInt cong(int amount) {
    if (count >= amount) {
      count.value = amount;
      return count;
    } else {
      count = count + 1;
      return count;
    }
  }

  RxInt tru() {
    if (count <= 0) {
      count.value = 0;
      return count;
    } else {
      count = count - 1;
      return count;
    }
  }

  // cong() => count++;
  // tru() => count--;
  @override
  void onClose() {
    super.onClose();
  }
}

class HappyShopProductDetail extends StatelessWidget {
  HappyShopProductDetail({
    Key? key,
    required this.productModel,
  }) : super(key: key);
  final ProductModel productModel;
  final storage = const FlutterSecureStorage();
  final addcouter = Get.put(AddcouterprocutController());
  ScrollController controller = new ScrollController();
  final AddProductCartController addProductCartController =
      Get.put(AddProductCartController());

  Future<void> addproductcart() async {
    var userId = await storage.read(key: 'userId');
    var bool = addProductCartController.addProduct(
        int.parse(userId!), productModel.productId, addcouter.count.value);
    if (await bool) {
      Get.to(() => HappyShopCart());
    }
  }

  // @override
  _showContent() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            child: ScreenTypeLayout(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    splashColor: primary.withOpacity(0.2),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilder(
                      //       transitionDuration: Duration(seconds: 1),
                      //       pageBuilder: (_, __, ___) =>
                      //           HappyShopProductPreview(),
                      //     ));
                    },
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFF333333).withOpacity(0.5),
                                ),
                                onPressed: () {
                                  Get.back();
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0xFF333333)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onTap: () {}),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: new Stack(children: <Widget>[
                                        Center(
                                          child: Icon(
                                            Icons.shopping_cart_rounded,
                                            color: Color(0xFF333333)
                                                .withOpacity(0.5),
                                            size: 26,
                                          ),
                                        ),
                                        (CUR_CART_COUNT != null &&
                                                CUR_CART_COUNT.isNotEmpty &&
                                                CUR_CART_COUNT != "0")
                                            ? new Positioned(
                                                top: 0.0,
                                                right: 5.0,
                                                bottom: 15,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red),
                                                    child: new Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: new Text(
                                                          CUR_CART_COUNT,
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            : Container()
                                      ]),
                                      onTap: () async {
                                        Get.to(HappyShopCart());
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           HappyShopCart(),
                                        //     ));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  // _slider(),
                  SizedBox(
                    height: 5.0,
                  ),
                  _image(),
                  _rate(),
                  _price(),
                  // _offPrice(),
                  _title(),
                  _desc(),
                ],
              ),
            ),
          ),
        ),
        _tanggiambtn(),
        GestureDetector(
          onTap: () {
            addproductcart();
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: happyshopgradient,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Center(
                child: Text(
              "Thêm vào giỏ hàng",
            )),
          ),
        ),
      ],
    );
  }

  // _madeIn() {
  _rate() {
    return Row(
      children: [
        Card(
          margin: const EdgeInsets.only(left: 20.0, bottom: 5),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                ),
                Text(productModel.rating.toString())
              ],
            ),
          ),
        ),
        Text(
          "/ " + productModel.userRating.toString() + " Đánh giá",
          // style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 239, 26, 7)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productModel.productStatus,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  _price() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          children: [
            Text(
              CUR_CURRENCY + " " + productModel.priceProduct.toString(),
              style: TextStyle(color: Colors.pink, fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            Text(productModel.priceDeposit.toString() + '%',
                style: TextStyle(
                    color: Color.fromARGB(255, 250, 51, 20),
                    fontSize: 16.0,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold)),
          ],
        ));
  }

  _image() {
    // return listimageproductdetail();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Image.network(
          "https://happyshop1233.herokuapp.com/" + productModel.avatar,
        )
        // productDetailController.productdetail[0].priceProduct.toString(),
        // style: Theme.of(context).textTheme.headline6),
        );
  }

  // _offPrice() {
  _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        productModel.productName,
        // productDetailController.productdetail[0].productName,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  _desc() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(productModel.description
          // productDetailController.productdetail[0].description
          ),
    );
  }

  _tanggiambtn() {
    return Container(
      // decoration: BoxDecoration(color: Colors.black),
      // width: 500,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: Icon(
                Icons.remove,
                size: 50,
                color: Colors.pink,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            onTap: () {
              addcouter.tru();
            },
          ),
          SizedBox(
            width: 20,
          ),
          Obx(() => Text(
                addcouter.count.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              )),
          SizedBox(
            width: 20,
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Icon(
                Icons.add,
                size: 50,
                color: Colors.pink,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
            onTap: () {
              addcouter.cong(productModel.amountProduct);
            },
          )
        ],
      ),
    );
  }

  // _selectVarientTitle() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(0),
        //   child: AppBar(elevation: 0, brightness: Brightness.light, backgroundColor: Colors.white.withOpacity(0.8)),
        // ),
        body: Stack(
      children: <Widget>[
        Text(""),
        _showContent(),
      ],
    ));
  }
}

// class listimageproductdetail extends StatelessWidget {
//   listimageproductdetail({
//     Key? key,
//     required this.productModel,
//   }) : super(key: key);
//   final ProductModel productModel;
//   List homeSliderList = [];
//   int _current = 0;

//   @override
//   Widget build(BuildContext context) {
//     homeSliderList.add(productModel.avatar);
//     for(int i=0;i<productModel.listImage.length;i++){
//       homeSliderList.add(productModel.listImage[i].imageUrl);
//     }
//     // homeSliderList.addAll(productModel.listImage);
//     return Column(children: [
//       CarouselSlider(
//         items: child as List<Widget>?,
//         options: CarouselOptions(
//           autoPlay: true,
//           enlargeCenterPage: false,
//           viewportFraction: 1.0,
//           aspectRatio: 2.0,
//           onPageChanged: (index, reason) {
//             // setState(() {
//             //   _current = index;
//             // });
//           },
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: homeSliderList
//             .map((item) => Container(
//                   width: _current == homeSliderList.indexOf(item) ? 30.0 : 10.0,
//                   height: 8.0,
//                   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: _current == homeSliderList.indexOf(item)
//                           ? primary
//                           : Color.fromRGBO(0, 0, 0, 0.1)),
//                 ))
//             .toList(),
//       )
//     ]);
//   }
// }

// final List<Widget> child = homeSliderList.map((item) {
//   return Container(
//     margin: EdgeInsets.all(5.0),
//     child: ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//       child: Stack(children: <Widget>[
//         CachedNetworkImage(
//           imageUrl: item["img"],
//           fit: BoxFit.fill,
//           width: 1000.0,
//           height: double.infinity,
//         ),
//       ]),
//     ),
//   );
// }
    /*},*/
    // ).toList();
/*CachedNetworkImage(
            imageUrl: i,
            fit: BoxFit.fill,
            width: 1000.0,
            height: double.infinity,
          ),*/

