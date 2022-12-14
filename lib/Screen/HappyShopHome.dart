import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_button/like_button.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Screen/HappyShopFavrite.dart';
import 'package:smartkit/Screen/HappyShopHomeTab.dart';
import 'package:smartkit/Screen/HappyShopNotification.dart';
import 'package:smartkit/Screen/HappyShopTrackOrder.dart';
import 'package:smartkit/controllers/category_controller.dart';
import 'package:smartkit/widget/HappyShopAppBar.dart';
import 'package:smartkit/widget/HappyShopDrawer.dart';
import 'package:get/get.dart';

import '../dangtin/dang_tin_screen.dart';
import '../models/category_model.dart';

class HappyShopHome extends StatefulWidget {
  HappyShopHome({Key? key}) : super(key: key);

  @override
  _HappyShopHomeState createState() => _HappyShopHomeState();
}

class _HappyShopHomeState extends State<HappyShopHome> {
  late List<Widget> happyShopBottomeTab;
  int _curSelected = 0;

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    _curSelected = 0;
    happyShopBottomeTab = [
      HappyShopHomeTab(),
      HappyShopFavrite(
        appbar: false,
      ),
      HappyShopNotification(
        appbar: false,
      ),
      HappyShopTreackOrder(
        appbar: false,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: HappyShopAppBar(),
      ),
      drawer: HappyShopDrawer(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: getBottomBar(),
      body: happyShopBottomeTab[_curSelected],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 60.0,
        height: 60.0,
        child: FloatingActionButton(
            backgroundColor: Colors.deepOrange[500],
            child: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  context: context,
                  builder: (builder) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Chọn danh mục',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          new Container(
                            height: 500,
                            color: Colors
                                .transparent, //could change this to Color(0xFF737373),
                            //so you don't have to change MaterialApp canvasColor
                            child: new Container(
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(10.0),
                                        topRight: const Radius.circular(10.0))),
                                child: new Center(
                                  child: new ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount:
                                          categoryController.state?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.network(
                                                "https://happyshop1233.herokuapp.com/" +
                                                    categoryController
                                                        .state![index]
                                                        .categoryIcon,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(categoryController
                                              .state![index].categoryName),
                                          onTap: () {
                                            danhmucsanphambottomshet(
                                                categoryController
                                                    .state![index]);
                                          },
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        );
                                      }),
                                )),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }

  getBottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(color: Color.fromARGB(66, 130, 45, 45), blurRadius: 10)
          //   ],
          // ),
          child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _curSelected,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Trang chủ',
              icon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 0);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.home_outlined,
                    size: 24,
                    color: Color(0x31333333).withOpacity(0.5),
                  );
                },
              ),
              activeIcon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 0);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.home_sharp,
                    size: 24,
                    color: happyshopcolor2,
                  );
                },
              ),
            ),
            BottomNavigationBarItem(
              label: 'Yêu thích',
              icon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 1);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite_border,
                    size: 24,
                    color: Color(0x31333333).withOpacity(0.5),
                  );
                },
              ),
              activeIcon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 1);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    size: 24,
                    color: happyshopcolor2,
                  );
                },
              ),
            ),
            BottomNavigationBarItem(
              label: 'Thông báo',
              icon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 2);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.notifications_none,
                    size: 24,
                    color: Color(0x31333333).withOpacity(0.5),
                  );
                },
              ),
              activeIcon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 2);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.notifications,
                    size: 24,
                    color: happyshopcolor2,
                  );
                },
              ),
            ),
            BottomNavigationBarItem(
              label: 'Hóa đơn',
              icon: LikeButton(
                size: 24.0,
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 3);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.directions_bike_outlined,
                    size: 24,
                    color: Color(0x31333333).withOpacity(0.5),
                  );
                },
              ),
              activeIcon: LikeButton(
                onTap: (bool isLiked) {
                  return onNavigationTap(isLiked, 3);
                },
                circleColor:
                    CircleColor(start: primary, end: primary.withOpacity(0.1)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: primary,
                  dotSecondaryColor: primary.withOpacity(0.1),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.directions_bike,
                    size: 24,
                    color: happyshopcolor2,
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future danhmucsanphambottomshet(CategoryModel categoryModel) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Chọn chi tiết danh mục',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                new Container(
                  height: 500,
                  color: Colors
                      .transparent, //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: new Center(
                        child: new ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: categoryModel.categoryDetail.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.network(
                                      "https://happyshop1233.herokuapp.com/" +
                                          categoryModel.categoryDetail[index]
                                              .categoryDetailIcon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(categoryModel
                                    .categoryDetail[index].categoryDetailName),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DangTinScreen()),
                                  );
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              );
                            }),
                      )),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> onNavigationTap(bool isLiked, int index) async {
    setState(() {
      _curSelected = index;
    });
    return !isLiked;
  }
}
