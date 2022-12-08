import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../controllers/add_product_cart.dart';
import '../data/data.dart';
import 'HappyShopCheckout.dart';
import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';
import 'HappyShopUser.dart';

class HappyShopCart extends GetView<GetProductCartController> {
  HappyShopCart({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;
  final GetProductCartController getProductCartController =
      Get.put(GetProductCartController());
  final addcouter = Get.put(AddcouterprocutController());
  final data = Get.put(Data());

  // final price = Get.put(Price());
  final storage = const FlutterSecureStorage();

  final DeleteProductCartController deleteProductCartController =
      Get.put(DeleteProductCartController());

  var totalPrice = 0.0.obs;
  var promotion = 0.0.obs;
  var price = 0.0.obs;

  List cartList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'name': "Nike",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90",
      'qty': "1",
      'totle': '2500'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'name': "Bag",
      'descprice': "1000",
      'price': "1200",
      'rating': "2.5",
      'noOfRating': "50",
      'qty': "1",
      'totle': '1000'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak3.jpg",
      'name': "Puma Shoes",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45",
      'qty': "1",
      'totle': '1300'
    },
    {
      'img':
          "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg",
      'name': "NIkeShoes",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150",
      'qty': "1",
      'totle': '1700'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
      'name': "Bag",
      'descprice': "2000",
      'price': "2200",
      'rating': "2.5",
      'noOfRating': "10",
      'qty': "1",
      'totle': '2000'
    },
  ];
  Future<void> cong(int count, int amount) async {
    if (count > amount) {
      count = amount;
      print(count);
    } else {
      count = count + 1;
      print(count);
    }
  }

  Future<void> tru(int count) async {
    if (count <= 0) {
      count = 0;
    } else {
      count = count - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut((() => GetProductCartController()));
    Get.lazyPut((() => DeleteProductCartController()));
    listproductcart();

    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(CART, context),
      body: Stack(
        children: <Widget>[
          _showContent(),
        ],
      ),
    );
  }

  final listCount1 = [].obs;
//my
  Future<void> listproductcart() async {
    var userId = await storage.read(key: 'userId');
    await getProductCartController.listCart(int.parse(userId!));

    for (int j = 0; j < getProductCartController.state!.length; j++) {
      var listCount = [].obs;
      var count = 0.obs;
      var dateList = <Item>[].obs;
      for (int i = 0;
          i < getProductCartController.state![j].listCart.length;
          i++) {
        dateList.add(Item(
            getProductCartController.state![j].listCart[i].cartId.toString()));
        count.value =
            getProductCartController.state![j].listCart[i].amountProduct;
        print(count.value);
        listCount.add(count);
      }

      list.add(dateList);
      listCount1.add(listCount);
    }
  }

//my
  final list = [].obs;
  List<int> listProductId = [];
  List<int> listAmount = [];
  Future<void> deleteCart(int cartId) async {
    var bool = await deleteProductCartController.deleteCart(cartId);
    if (bool) {
      Get.to(() => HappyShopCart());
    }
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  Future<void> payPrice() async {
    listProductId = [];
    listAmount = [];
    price.value = 0.0;
    promotion.value = 0.0;
    totalPrice.value = 0.0;
    for (int j = 0; j < getProductCartController.state!.length; j++) {
      for (int i = 0;
          i < getProductCartController.state![j].listCart.length;
          i++) {
        if (list[j][i].seleted.value) {
          totalPrice.value = totalPrice.value +
              getProductCartController
                      .state![j].listCart[i].product.priceProduct *
                  getProductCartController.state![j].listCart[i].amountProduct;

          promotion.value = promotion.value +
              getProductCartController
                      .state![j].listCart[i].product.priceProduct *
                  getProductCartController
                      .state![j].listCart[i].product.priceDeposit /
                  100 *
                  getProductCartController.state![j].listCart[i].amountProduct;
          price.value = totalPrice.value - promotion.value;
          listProductId
              .add(getProductCartController.state![j].listCart[i].productId);
          listAmount.add(
              getProductCartController.state![j].listCart[i].amountProduct);
        }
      }
    }
    data.listAmount = listAmount;
    data.listProductId = listProductId;
    data.price = price.value;
    data.promotion = promotion.value;
    data.totalPrice = totalPrice.value;
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

  _showContent() {
    return controller
        .obx((state) => getProductCartController.state![0].listCart.length == 0
            ? cartEmpty()
            : ScreenTypeLayout(
                mobile: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: getProductCartController.state?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return controller.obx((state) => Column(
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
                                                        BorderRadius.circular(
                                                            25.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "https://happyshop1233.herokuapp.com/" +
                                                              getProductCartController
                                                                  .state![index]
                                                                  .user
                                                                  .avatar,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.fill,
                                                    )),
                                                onTap: () {
                                                  print("bam duoc");
                                                },
                                              ),
                                              Text(
                                                getProductCartController
                                                    .state![index]
                                                    .user
                                                    .username,
                                                style: TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 15),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Xem",
                                                style: TextStyle(
                                                    color: Colors.pink),
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
                                          Get.to(HappyShopUser());
                                        }),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: getProductCartController
                                        .state![index].listCart.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, indexCart) {
                                      return listItem(index, indexCart);
                                    },
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 28, bottom: 8.0, left: 35, right: 35),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Tổng tiền",
                          ),
                          Spacer(),
                          Obx(() => Text(totalPrice.value.toString())),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, top: 8, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Khuyến mãi",
                          ),
                          Spacer(),
                          Obx(() => Text(promotion.value.toString())),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 35, right: 35),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Còn lại",
                            // style: Theme.of(context)
                            //     .textTheme
                            //     .subtitle1!
                            //     .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Obx(
                            () => Text(price.value.toString()),

                            // style: Theme.of(context)
                            //     .textTheme
                            //     .subtitle1!
                            //     .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Get.to(HappyShopCheckout());
                      },
                      child: Container(
                        height: 55,
                        decoration: back(),
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "Đặt hàng",
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .subtitle1!
                          //     .copyWith(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget listItem(int index, int indexCart) {
    return Card(
      elevation: 0.1,
      child: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              // decoration: BoxDecoration(color: Colors.blue),
              width: 30,
              height: 50,
              child: Obx(
                () => CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: Colors.pink,
                  value: list[index][indexCart].seleted.value,
                  onChanged: (val) {
                    // val == true
                    //     ? checkeditem.selected.value = false
                    //     : checkeditem.selected.value = true;
                    // for(int i=0;i<dateList.length-1;i++){
                    // if(dateList[i].title==getProductCartController.state![index].listCart[indexCart].cartId.toString()){
                    list[index][indexCart].seleted.value = val ?? false;
                    list[index].refresh();
                    payPrice();
                    // }
                    // }
                  },
                ),
              ),
            ),
            Container(
              child: Image.network(
                "https://happyshop1233.herokuapp.com/" +
                    getProductCartController
                        .state![index].listCart[indexCart].product.avatar,
                height: 130.0,
                width: 100.0,
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
                              getProductCartController.state![index]
                                  .listCart[indexCart].product.productName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: 
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Text(
                            " (" +
                                getProductCartController.state![index]
                                    .listCart[indexCart].product.rating
                                    .toString() +
                                ")",
                            // style: Theme.of(context).textTheme.overline,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            getProductCartController.state![index]
                                    .listCart[indexCart].product.priceDeposit
                                    .toString() +
                                "%",
                            style: TextStyle(color: Colors.pink),
                            // style: Theme.of(context).textTheme.overline,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          getProductCartController.state![index]
                                  .listCart[indexCart].product.priceProduct
                                  .toString() +
                              "VND",
                          style: TextStyle(
                              // decoration: TextDecoration.lineThrough,
                              letterSpacing: 0.7,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    // cong tru
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 8, top: 8, bottom: 8),
                                child: Icon(
                                  Icons.remove,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              onTap: () {
                                tru(listCount1[index][indexCart].value);
                              },
                            ),
                            Text(getProductCartController
                                .state![index].listCart[indexCart].amountProduct
                                .toString()),
                            // Obx(
                            //   () => Text(
                            //     listCount1[index][indexCart].value.toString(),
                            //     // style: Theme.of(context).textTheme.caption,
                            //   ),
                            // ),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              onTap: () {
                                cong(
                                    listCount1[index][indexCart].value,
                                    getProductCartController.state![index]
                                        .listCart[indexCart].amountProduct);
                              },
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          "",
                          // style: Theme.of(context).textTheme.headline6
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Icon(
                  Icons.close,
                  size: 13,
                ),
              ),
              onTap: () {
                // deleteCart(getProductCartController.state![index].cartId);
              },
            )
          ],
        ),
        splashColor: primary.withOpacity(0.2),
        onTap: () async {},
      ),
    );
  }

  cartEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // noCartImage(context),
          // noCartText(context),
          // noCartDec(context),
          shopNow()
        ]),
      ),
    );
  }

  noCartImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://smartkit.wrteam.in/smartkit/images/empty_cart.png',
      fit: BoxFit.contain,
    );
  }

  noCartText(BuildContext context) {
    return Container(
        child: Text(NO_CART,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: primary, fontWeight: FontWeight.normal)));
  }

  noCartDec(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: Text(CART_DESC,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: lightblack,
                fontWeight: FontWeight.normal,
              )),
    );
  }

  shopNow() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: CupertinoButton(
        child: Container(
            width: deviceWidth * 0.7,
            height: 45,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryLight2, primaryLight3],
                  stops: [0, 1]),
              borderRadius: new BorderRadius.all(const Radius.circular(50.0)),
            ),
            child: Text(
              SHOP_NOW,
              textAlign: TextAlign.center,
              // style: Theme.of(context)
              //     .textTheme
              //     .headline6!
              //     .copyWith(color: white, fontWeight: FontWeight.normal)
            )),
        onPressed: () {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => HappyShopHome()),
          //     ModalRoute.withName('/'));
        },
      ),
    );
  }

  back() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLight2, primaryLight3],
          stops: [0, 1]),
    );
  }
}

class Item {
  Item(this.title);
  String title;
  RxBool seleted = false.obs;
  @override
  String toString() => title;
}

class Count extends GetxController {
  var listCount = [].obs;
}
