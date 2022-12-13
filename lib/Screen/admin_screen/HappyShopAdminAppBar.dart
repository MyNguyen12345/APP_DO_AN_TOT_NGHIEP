import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopCart.dart';
import 'package:smartkit/Screen/HappyShopProfile.dart';

class HappyShopAdminAppBar extends StatelessWidget {
  const HappyShopAdminAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Admin HappyShop",
            style: TextStyle(
              color: Color(0xFF333333),
              fontFamily: 'Open sans',
            ),
          )
        ],
      ),
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Color(0xFF333333).withOpacity(0.5)),
      actions: <Widget>[
        InkWell(
          child: Icon(
            Icons.account_circle,
            color: Color(0xFF333333).withOpacity(0.5),
            size: 26,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopPeofile(),
                ));
          },
        ),
        SizedBox(
          width: 10.0,
        ),
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: happyshopgradient
        ),
      ),
      elevation: 2.0,
    );
  }
}
