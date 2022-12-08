import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopStaggeredList.dart';
import 'package:smartkit/controllers/category_controller.dart';

import 'HappyShopProductDetail.dart';

class HappyShopCatogeryAll extends GetView<CategoryController> {
  HappyShopCatogeryAll({Key? key}) : super(key: key);

  int offset = perPage;
  int total = 0;
  ScrollController scrollController = new ScrollController();
  final CategoryController categoryController = Get.put(CategoryController());
  List tempList = [];

  List catList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Electronic.png",
      'title': "Electronics"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Household.png",
      'title': "Household"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Vegetables.png",
      'title': "Vegetables"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/fashion.png",
      'title': "fashion"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Grocery.png",
      'title': "Grocery"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/phone2.jpg",
      'title': "Phone"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'title': "Shoes"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'title': "Bag"
    },
  ];

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
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(ALL_CAT, context),
        body: controller.obx((state) => GridView.count(
            controller: scrollController,
            padding: EdgeInsets.all(20),
            crossAxisCount: 4,
            shrinkWrap: true,
            childAspectRatio: .8,
            physics: BouncingScrollPhysics(),
            children: List.generate(
              (offset < total)
                  ? categoryController.state!.length + 1
                  : categoryController.state!.length,
              (index) {
                return (index == categoryController.state!.length)
                    ? Center(child: CircularProgressIndicator())
                    : catItem(index, context);
              },
            ))));
  }

  Widget catItem(int index, BuildContext context) {
    return InkWell(
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: CachedNetworkImage(
                  imageUrl:
                      // "https://smartkit.wrteam.in/smartkit/happyshop/cat_1.png",
                      "https://happyshop1233.herokuapp.com/" +
                          categoryController.state![index].categoryIcon,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                categoryController.state![index].categoryName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.black),
              ),
            )
          ],
        ),
        onTap: () {
          Get.to(() => HappyShopStaggeredList(
                categoryModel: categoryController.state![index],
              ));
        });
  }
}
