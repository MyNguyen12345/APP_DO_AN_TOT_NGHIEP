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

import 'HappyShopAdminAppBar.dart';
import 'HappyShopAdminDashboard.dart';
import 'HappyShopAdminDrawer.dart';

class HappyShopAdminHome extends StatefulWidget {
  HappyShopAdminHome({Key? key}) : super(key: key);

  @override
  _HappyShopAdminHomeState createState() => _HappyShopAdminHomeState();
}

class _HappyShopAdminHomeState extends State<HappyShopAdminHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: HappyShopAdminAppBar(),
      ),
      drawer: HappyShopAdminDrawer(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      extendBodyBehindAppBar: true,
      // bottomNavigationBar: getBottomBar(),
      body: PlaningGrid(),
    );
  }
}
