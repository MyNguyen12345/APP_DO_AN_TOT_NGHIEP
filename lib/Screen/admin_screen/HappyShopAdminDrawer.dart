import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopCart.dart';
import 'package:smartkit/Screen/HappyShopFavrite.dart';
import 'package:smartkit/Screen/HappyShopHome.dart';
import 'package:smartkit/Screen/HappyShopLogin.dart';
import 'package:smartkit/Screen/HappyShopNotification.dart';
import 'package:smartkit/Screen/HappyShopOrderUser.dart';
import 'package:smartkit/Screen/HappyShopSingUp.dart';
import 'package:smartkit/Screen/HappyShopTrackOrder.dart';
import 'package:smartkit/Screen/HappyShopProfile.dart';

import 'HappShopAdminPost.dart';
import 'HappyShopAdminAppBar.dart';
import 'HappyShopAdminHome.dart';
import 'HappyShopAdminUser.dart';

class HappyShopAdminDrawer extends StatelessWidget {
  const HappyShopAdminDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          HappyShopDrawerHeader(),
          HappyShopDrawerListTile(
            title: "Dashboard",
            icon: Icons.home,
            route: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopAdminHome(),
                ),
              );
            },
          ),

          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/profile.svg",
            title: "Quản lý khách hàng",
            icon: Icons.person,
            route: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappShopAdminUser(),
                ),
              );
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl:
                "https://smartkit.wrteam.in/smartkit/happyshop/pro_notification.svg",
            title: "Duyệt bài đăng",
            icon: Icons.notification_important,
            route: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopAdminPost(
                    appbar: true,
                  ),
                ),
              );
            },
          ),

          _getDivider(),
          HappyShopDrawerListTile(
            title: "Đăng Xuất",
            icon: Icons.login,
            route: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopLogin(),
                ),
              );
            },
          ),
          // _getDivider(),
          // HappyShopDrawerListTile(
          //   title: "SingUp",
          //   icon: Icons.account_box_rounded,
          //   route: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HappyShopSingUp(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  _getDivider() {
    return Divider(
      color: Colors.grey,
      height: 1,
    );
  }
}

class HappyShopDrawerListTile extends StatelessWidget {
  final IconData icon;
  final String? title, imgurl;
  final Function route;
  final bool img;
  const HappyShopDrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
    this.img = false,
    this.imgurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: img == true
            ? SvgPicture.network(
                imgurl!,
                width: 28.0,
                color: happyshopcolor2,
              )
            : Icon(
                icon,
                color: happyshopcolor2,
              ),
        title: Text(
          title!,
          style: TextStyle(color: textcolor),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: happyshopcolor2,
        ),
        onTap: route as void Function()?);
  }
}

class HappyShopDrawerHeader extends StatelessWidget {
  const HappyShopDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: happyshopgradient),
      padding: EdgeInsets.only(top: 24),
      child: InkWell(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            // margin: EdgeInsets.all(35),
            child: Row(
              children: [
                SvgPicture.network(
                  'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
                  width: 60.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 26,
                ),
                Text(
                  "Happy Shop",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Open sans',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
