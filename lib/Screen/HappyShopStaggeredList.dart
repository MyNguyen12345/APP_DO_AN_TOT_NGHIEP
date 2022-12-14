import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopCatgories.dart';
import 'package:smartkit/Screen/HappyShopProductDetail.dart';
import 'package:smartkit/controllers/category_controller.dart';
import 'package:smartkit/controllers/user_controller.dart';
import 'package:smartkit/desktop/hometabdesktop.dart';
import 'package:smartkit/models/category_model.dart';
import 'package:smartkit/models/product_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controllers/product_controllers.dart';
import 'HappyShopHome.dart';
import 'HappyShopStaggeredList.dart';

class HappyShopStaggeredList extends GetView<ProductCategoryController> {
  HappyShopStaggeredList({Key? key, required this.categoryModel})
      : super(key: key);
  final CategoryModel? categoryModel;

  final _controller = PageController();
  final ProductController productController = Get.put(ProductController());
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController());

  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;
  Future<void> listProduct(int id) async {
    await productCategoryController.productsCategoryDetail(id);
    productCategoryController.state!.length;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut((() => ProductCategoryController()));
    listProduct(categoryModel!.categoryDetail[0].categoryDetailId);

    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HappyShopHome()),
                (Route<dynamic> route) => false)
            .then((value) => value as bool);
        //  Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ,
        //   ),
        // );
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    // margin: EdgeInsets.only(
                    //     bottom: 0,
                    //     top: kToolbarHeight * 1.4,
                    //     right: 0,
                    //     left: 0),
                    child: CarouselWithIndicator()),
                Column(
                  children: [
                    // category //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
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
                              Get.to(() => HappyShopCatogeryAll());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: controller.obx(
                        (state) => ListView.builder(
                          itemCount: categoryModel!.categoryDetail.length,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: new ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://happyshop1233.herokuapp.com/" +
                                                        categoryModel!
                                                            .categoryDetail[
                                                                index]
                                                            .categoryDetailIcon,
                                                fit: BoxFit.fill,
                                                width: 50,
                                                height: 50,
                                              ))
                                          //  new CachedNetworkImage(
                                          //   imageUrl:
                                          //       "https://smartkit.wrteam.in/smartkit/happyshop/cat_1.png",
                                          //   // " https://datn123.herokuapp.com/"+categoryController.state![index].categoryIcon,
                                          //   height: 50.0,
                                          //   width: 50.0,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          ),
                                    ),
                                    Container(
                                      child: Text(
                                        categoryModel!.categoryDetail[index]
                                            .categoryDetailName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      width: 65,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                listProduct(categoryModel!
                                    .categoryDetail[index].categoryDetailId);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _getHeading("Sản phẩm bán chạy"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ScreenTypeLayout(
                        mobile: Container(
                          //                   controller.obx(
                          // (state) => ListView.separated(
                          child:
                              // Obx(() =>
                              controller.obx((state) => GridView.count(
                                  padding: EdgeInsets.only(top: 5),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  childAspectRatio: 0.7,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                    productCategoryController.state!.length,
                                    (index) {
                                      return InkWell(
                                        onTap: () => Get.to(
                                          HappyShopProductDetail(
                                            productModel:
                                                productCategoryController
                                                    .state![index],
                                          ),
                                        ),
                                        child: ItemCard(
                                          voucher: productCategoryController
                                              .state![index].priceDeposit
                                              .toInt(),
                                          status: productCategoryController
                                              .state![index].productStatus,
                                          imagurl:
                                              "https://happyshop1233.herokuapp.com/" +
                                                  productCategoryController
                                                      .state![index].avatar,
                                          itemname: productCategoryController
                                              .state![index].productName,
                                          price: productCategoryController
                                              .state![index].priceProduct,
                                          rating: productCategoryController
                                              .state![index].rating,
                                          shadow: false,
                                        ),
                                      );
                                    },
                                  ))),
                          // )
                        ),
                      ),
                    ),
                    // New arrival for men's //
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("All category details"),
        ),
      ),
    );
  }

  _getHeading(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              InkWell(
                child: Text(
                  seeAll,
                ),
                splashColor: primary.withOpacity(0.2),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //       transitionDuration: Duration(seconds: 1),
                  //       pageBuilder: (_, __, ___) => HappyShopStaggeredList()),
                  // );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void _animateSlider() {
  //   Future.delayed(Duration(seconds: 30)).then((_) {
  //     if (mounted) {
  //       int nextPage = _controller.hasClients
  //           ? _controller.page!.round() + 1
  //           : _controller.initialPage;

  //       if (nextPage == homeSliderList.length) {
  //         nextPage = 0;
  //       }
  //       if (_controller.hasClients)
  //         _controller
  //             .animateToPage(nextPage,
  //                 duration: Duration(seconds: 1), curve: Curves.easeIn)
  //             .then((_) => _animateSlider());
  //     }
  //   });
  // }

  // List<T?> map<T>(List homeSliderList, Function handler) {
  //   List<T?> result = [];
  //   for (var i = 0; i < homeSliderList.length; i++) {
  //     result.add(handler(i, homeSliderList[i]));
  //   }

  //   return result;
  // }
}

// class ItemCardSmall extends StatelessWidget {
//   const ItemCardSmall({
//     Key? key,
//     this.imagurl,
//     this.rating,
//     this.itemname,
//     this.descprice,
//     this.price,
//     this.shadow,
//   }) : super(key: key);
//   final String? imagurl, rating, itemname, descprice, price;
//   final bool? shadow;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [BoxShadow(color: happyshopcolor5, blurRadius: 10)],
//       ),
//       child: Card(
//         elevation: 0.0,
//         child: InkWell(
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.2,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                   child: Stack(
//                     alignment: Alignment.topRight,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 0.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               topRight: Radius.circular(5)),
//                           child: CachedNetworkImage(
//                             imageUrl: imagurl!,
//                             width: double.infinity,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(1.5),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 10,
//                               ),
//                               Text(
//                                 rating!,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .overline!
//                                     .copyWith(letterSpacing: 0.2),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Text(
//                     itemname!,
//                     style: Theme.of(context).textTheme.overline!.copyWith(
//                         color: Colors.black,
//                         fontSize: 16.0,
//                         letterSpacing: 0.5),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5, left: 5),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Text(CUR_CURRENCY + "" + descprice!,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .overline!
//                                     .copyWith(
//                                         decoration: TextDecoration.lineThrough,
//                                         letterSpacing: 1),
//                                 textAlign: TextAlign.left),
//                             Text(
//                               CUR_CURRENCY + " " + price!,
//                               style: TextStyle(color: primary),
//                               textAlign: TextAlign.left,
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 3),
//                             child: Icon(
//                               Icons.favorite,
//                               size: 15,
//                               color: primary,
//                             ),
//                           ),
//                           onTap: () {})
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           onTap: () {},
//         ),
//       ),
//     );
//   }
// }

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    this.imagurl,
    this.rating,
    this.itemname,
    this.price,
    this.shadow,
    this.status,
    this.voucher,
  }) : super(key: key);

  final String? imagurl, itemname;
  final bool? shadow;
  final double? rating;
  final double? price;
  final String? status;
  final int? voucher;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
                    Text(" " + CUR_CURRENCY + " " + widget.price!.toString(),
                        style: TextStyle(color: primary)),
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

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child as List<Widget>?,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: homeSliderList
            .map((item) => Container(
                  width: _current == homeSliderList.indexOf(item) ? 30.0 : 10.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _current == homeSliderList.indexOf(item)
                          ? primary
                          : Color.fromRGBO(0, 0, 0, 0.1)),
                ))
            .toList(),
      )
    ]);
  }
}

final List<Widget> child = homeSliderList.map((item) {
  return Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(children: <Widget>[
        CachedNetworkImage(
          imageUrl: item["img"],
          fit: BoxFit.fill,
          width: 1000.0,
          height: double.infinity,
        ),
      ]),
    ),
  );
}
    /*},*/
    ).toList();
/*CachedNetworkImage(
            imageUrl: i,
            fit: BoxFit.fill,
            width: 1000.0,
            height: double.infinity,
          ),*/
List homeSliderList = [
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_a.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_b.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_c.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_d.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_e.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_f.png",
  },
  {
    "img": "https://smartkit.wrteam.in/smartkit/happyshop/slider_g.png",
  }
];
