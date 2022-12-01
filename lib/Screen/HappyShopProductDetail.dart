import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
  increment() => count++;
  increment1() => count--;
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

  // bool isRelod;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController controller = new ScrollController();
  final AddProductCartController addProductCartController =
      Get.put(AddProductCartController());

  Future<void> addproductcart() async {
    var userId = await storage.read(key: 'userId');
    print("productDetailId" + productModel.productId.toString());
    var bool = addProductCartController.addProduct(
        int.parse(userId!), productModel.productId, 1);
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

                  // _selectVarientTitle(),
                  // _getVarient(_selVarient),
                  // _otherDetailsTitle(),
                  // _madeIn(),
                  // _cancleable(),
                  // _ratingReview(),
                  // _review(),
                  // _rating(),
                  // _writeReview()
                ],
              ),
              // desktop: ProductDetailsDesktop(
              //   imgurl: widget.imgurl,
              //   tag: widget.tag,
              //   listwidget: [
              //     _price(),
              //     _offPrice(),
              //     _title(),
              //     _desc(),
              //   ],
              // ),
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
              "Add to Cart",
              // style: Theme.of(context)
              //     .textTheme
              //     .button!
              //     .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
                Text("")
              ],
            ),
          ),
        ),
        Text(
          " " + "150" + " Ratings",
          // style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.yellow),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productModel.productStatus,
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }

  _price() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Text(
          CUR_CURRENCY + " " + productModel.priceProduct.toString(),
        )
        // productDetailController.productdetail[0].priceProduct.toString(),
        // style: Theme.of(context).textTheme.headline6),
        );
  }

  _image() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Image.network(
          "https://datn123.herokuapp.com/" + productModel.avatar,
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
              addcouter.increment1();
            },
          ),
          SizedBox(
            width: 20,
          ),
          Obx(() => Text(
                addcouter.count.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              addcouter.increment();
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
