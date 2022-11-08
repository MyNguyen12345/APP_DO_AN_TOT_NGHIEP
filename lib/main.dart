import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';

import 'Screen/HappyShopSplash.dart';
void main() => runApp(GetMaterialApp(home: MyApp()));
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
      home: HappyShopSplash(),
    );
  }
}
