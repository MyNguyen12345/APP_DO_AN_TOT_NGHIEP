import 'dart:io';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopCart.dart';
import 'package:smartkit/widget/HappyShopbtn.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_controller.dart';
import 'HappyShopHome.dart';

class texteditGetx extends GetxController {}

class HappyShopPeofile extends StatefulWidget {
  HappyShopPeofile({Key? key}) : super(key: key);

  @override
  _HappyShopPeofileState createState() => _HappyShopPeofileState();
}

class _HappyShopPeofileState extends State<HappyShopPeofile>
    with TickerProviderStateMixin {
  //chon anh
  File? _image;
  final ImagePicker _picker = ImagePicker();
  //chon anh
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  //chon anh
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final ImageTemporary = File(image.path);
    setState(() {
      this._image = ImageTemporary;
    });
  }

  String? name, email, mobile, city, area, pincode, address, image;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // TextEditingController? nameC, emailC, mobileC, pincodeC, addressC;
  bool isDateSelected = false;
  DateTime? birthDate;
  bool isSelected = false;
  bool _isNetworkAvail = true;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  final UserController userController = Get.put(UserController());
  final nameC = TextEditingController();
  final genderC = TextEditingController();
  final mobileC = TextEditingController();
  final dateC = TextEditingController();
  final addressC = TextEditingController();

  String get nameUser => nameC.text;
  String get genderUser => genderC.text;
  String get phoneUser => mobileC.text;
  String get dateUser => dateC.text;
  String get addressUser => addressC.text;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    image = "https://smartkit.wrteam.in/smartkit/images/profile2.png";

    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController!,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }

  // @override
  // void dispose() {
  //   buttonController!.dispose();
  //   mobileC?.dispose();
  //   nameC?.dispose();
  //   addressC!.dispose();
  //   addressC?.dispose();
  //   super.dispose();
  // }

  // Future<void> getUserId() async {

  setAddress() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                // validator: (value) =>
                //     value!.isEmpty ? userController.state!.address : null,
                keyboardType: TextInputType.text,
                controller: addressC,
                style: Theme.of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: darkgrey),
                onChanged: (v) => setState(() {
                  address = v;
                }),
                onSaved: (String? value) {
                  address = value;
                },
                decoration: InputDecoration(
                  // hintText: userController.state!.address,
                  hintStyle: Theme.of(this.context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: darkgrey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: new EdgeInsets.only(right: 30.0, left: 30.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: white),
                  color: white),
              child: IconButton(
                icon: new Icon(Icons.my_location),
                onPressed: () async {},
              ),
            )
          ],
        ));
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

  Future<void> checkNetwork() async {
    buttonController!.reverse();
    // print(nameUser);
    Get.to(HappyShopPeofile());
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
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

  profileImage() {
    return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Stack(
          children: <Widget>[
            image != null && image != ""
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: primary,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    "https://happyshop1233.herokuapp.com/" +
                                        userController.state!.avatar,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )))
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: primary,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primary)),
                        child: Icon(Icons.person, size: 100)),
                  ),
            Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  height: 30,
                  width: 30,
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: primary,
                        size: 15,
                      ),
                      onPressed: getImage),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(color: primary)),
                )),
          ],
        ));
  }

  updateBtn() {
    return AppBtn(
      title: UPDATE_PROFILE_LBL,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () {
        validateAndSubmit();
      },
    );
  }

  setUserName() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: nameC,
        style: Theme.of(this.context)
            .textTheme
            .subtitle1!
            .copyWith(color: darkgrey),
        onChanged: (v) => setState(() {
          name = v;
        }),
        onSaved: (String? value) {
          name = value;
        },
        decoration: InputDecoration(
          // hintText: userController.state!.username,
          hintStyle: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: new EdgeInsets.only(right: 30.0, left: 30.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setMobileNo() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: mobileC,
          readOnly: true,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          decoration: InputDecoration(
            // hintText: userController.state!.phone.toString(),
            hintStyle: Theme.of(this.context)
                .textTheme
                .subtitle1!
                .copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: new EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: genderC,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            email = v;
          }),
          onSaved: (String? value) {
            email = value;
          },
          decoration: InputDecoration(
            hintText: userController.state!.gender,
            hintStyle: Theme.of(this.context)
                .textTheme
                .subtitle1!
                .copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: new EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  setPincode() {
    double width = MediaQuery.of(this.context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.datetime,
          controller: dateC,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            addressC.text = v;
          }),
          onSaved: (String? value) {
            addressC.text = value!;
          },
          decoration: InputDecoration(
            // hintText: userController.state!.dateJoin,
            hintStyle: Theme.of(this.context)
                .textTheme
                .subtitle1!
                .copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: new EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  _showContent() {
    return ScreenTypeLayout(
      mobile: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                profileImage(),
                setUserName(),
                setEmail(),
                setMobileNo(),
                setAddress(),
                setPincode(),
                updateBtn(),
              ],
            ),
          ),
        ),
      ),
      desktop: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  profileImage(),
                  setUserName(),
                  setEmail(),
                  setMobileNo(),
                  setAddress(),
                  setPincode(),
                  updateBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    nameC.text = userController.state!.username;
    genderC.text = userController.state!.gender;
    mobileC.text = userController.state!.phone.toString();
    addressC.text = userController.state!.address;
    dateC.text = userController.state!.dateJoin;

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HappyShopHome(),
          ),
        ).then((value) => value as bool);
      } as Future<bool> Function()?,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: lightgrey,
        appBar: getAppBar(PROFILE, context),
        body: Center(
          child: _showContent(),
        ),
      ),
    );
  }
}
