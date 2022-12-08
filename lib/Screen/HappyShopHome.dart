import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_button/like_button.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Screen/HappyShopFavrite.dart';
import 'package:smartkit/Screen/HappyShopHomeTab.dart';
import 'package:smartkit/Screen/HappyShopNotification.dart';
import 'package:smartkit/Screen/HappyShopTrackOrder.dart';
import 'package:smartkit/widget/HappyShopAppBar.dart';
import 'package:smartkit/widget/HappyShopDrawer.dart';
import 'package:get/get.dart';

import '../dangtin/dang_tin_screen.dart';

class HappyShopHome extends StatefulWidget {
  HappyShopHome({Key? key}) : super(key: key);

  @override
  _HappyShopHomeState createState() => _HappyShopHomeState();
}

class _HappyShopHomeState extends State<HappyShopHome> {
  late List<Widget> happyShopBottomeTab;
  int _curSelected = 0;

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
                  builder: (context) {
                    return Container(
                      // MediaQuery.of(context).size.height * 0.9
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Đăng tin',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                // leading: const Icon(Icons.photo),
                                title: const Text(
                                  'Chọn danh mục',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  danhmucsanphambottomshet();
                                },
                                // trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Bất đống sản'),
                                onTap: () {
                                  danhmucsanphambottomshet();
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.music_note),
                                title: new Text(' Xe cộ'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.videocam),
                                title: new Text('Đồ điện tử'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.share),
                                title: new Text('Thú Cưng'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
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
              label: 'Home',
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
              label: 'Favorite',
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
              label: 'Notifications',
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
              label: 'Track Order',
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

  Future danhmucsanphambottomshet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Container(
            // MediaQuery.of(context).size.height * 0.9
            height: MediaQuery.of(context).size.height,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('gà chó mèo...'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DangTinScreen()),
                        );
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: new Icon(Icons.music_note),
                      title: new Text(' Xe cộ'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: new Icon(Icons.videocam),
                      title: new Text('Đồ điện tử'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: new Icon(Icons.share),
                      title: new Text('Thú Cưng'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
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
