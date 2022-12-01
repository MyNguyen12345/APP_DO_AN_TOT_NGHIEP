import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Screen/HappyShopHomeTab.dart';
import 'package:smartkit/Screen/HappyShopLogin.dart';
import 'package:smartkit/controllers/login_controller.dart';
import 'package:smartkit/controllers/product_controllers.dart';
import 'package:smartkit/provider/login_provider.dart';
import 'package:smartkit/provider/product_model_provider.dart';

import 'Screen/HappyShopSplash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Happy Shop",
      theme: ThemeData(
          primarySwatch: primary_app,
          textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
          fontFamily: 'Open sans',
          textTheme: TextTheme(
              headline6: TextStyle(
            color: primary,
            fontWeight: FontWeight.w600,
          ))),
      debugShowCheckedModeBanner: false,
      // initialBinding: BindingsBuilder(() {
      //   Get.put(ProductModelProvider());
      //   Get.put(ProductController());
      // }),
        initialBinding: BindingsBuilder(() {
        Get.put(LoginProvider());
        Get.put(LoginController());
      }),
      home: HappyShopSplash(),
    );
  }
}
