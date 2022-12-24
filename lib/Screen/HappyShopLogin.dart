import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopForgotPassword.dart';
import 'package:smartkit/Screen/HappyShopHome.dart';
import 'package:smartkit/Screen/HappyShopHomeTab.dart';
import 'package:smartkit/controllers/login_controller.dart';
import 'package:smartkit/desktop/logindesktop.dart';
import 'package:smartkit/widget/HappyShopbtn.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../controllers/user_controller.dart';
import 'HappyShopSingUp.dart';
import 'admin_screen/HappyShopAdminHome.dart';

class HappyShopLogin extends StatefulWidget {
  HappyShopLogin({Key? key}) : super(key: key);

  @override
  _HappyShopLoginState createState() => _HappyShopLoginState();
}

class _HappyShopLoginState extends State<HappyShopLogin>
    with TickerProviderStateMixin {
  String? password,
      mobile,
      username,
      email,
      id,
      countrycode,
      mobileUser,
      city,
      area,
      pincode,
      address,
      latitude,
      longitude,
      image;
  String? countryName;
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  final LoginController loginController = Get.put(LoginController());
  final UserController userController = Get.put(UserController());

  String get phone => mobileController.text;
  String get password1 => passwordController.text;

  Animation? buttonSqueezeanimation;

  AnimationController? buttonController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HappyShopHome(),
          ),
        ).then((value) => value as bool);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: height,
            width: width,
            decoration: back(),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 000))
                                .then((_) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HappyShopHome()));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              SKIP,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: white,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: new SvgPicture.network(
                        'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
                        width: 80.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScreenTypeLayout(
                      mobile: Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 20),
                                child: Form(
                                  key: _formkey,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        welcomeHappyShopTxt(),
                                        eCommerceforBusinessTxt(),
                                        // setCountryCode(),
                                        setMobileNo(),
                                        setPass(),
                                        forgetPass(),
                                        loginBtn(),
                                        accSignup(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> validatanmation() async {
    await buttonController!.reverse();
    var bool = loginController.login(int.parse(phone), password1);
    await userController.fetchUser(int.parse(phone));
    if (await bool) {
      await storage.write(key: 'token', value: loginController.state!.token);
      await storage.write(
          key: 'userId', value: userController.state!.userId.toString());
      await storage.write(key: 'phone', value: phone.toString());
      if(loginController.state?.roleName=='ROLE_USER'){
           Get.to(HappyShopHome());
      }else{
           Get.to(HappyShopAdminHome());
      }
   
    }
  }

  bool validateAndSave() {
    return true;
  }

  back() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLight2, primaryLight3],
          stops: [0, 1]),
    );
  }

  welcomeHappyShopTxt() {
    return Padding(
        padding: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: new Text(
            "Chào mừng bạn đến với HappyShop",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: pink, fontWeight: FontWeight.bold),
          ),
        ));
  }

  eCommerceforBusinessTxt() {
    return Padding(
        padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: new Text(
            "Mua và bán mọi thứ bạn muốn tại đây",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(color: pink),
          ),
        ));
  }

  // setCountryCode() {
  //   double height = MediaQuery.of(context).size.height * 0.9;
  //   double width = MediaQuery.of(context).size.width;
  //   return Padding(
  //       padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //         width: width,
  //         height: 50,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(7.0),
  //             border: Border.all(color: darkgrey)),
  //         child: CountryCodePicker(
  //             showCountryOnly: false,
  //             searchDecoration: InputDecoration(
  //               hintText: COUNTRY_CODE_LBL,
  //               fillColor: primary,
  //             ),
  //             showOnlyCountryWhenClosed: false,
  //             initialSelection: 'IN',
  //             alignLeft: true,
  //             dialogSize: Size(width, height),
  //             builder: _buildCountryPicker,
  //             onChanged: (CountryCode countryCode) {
  //               countrycode = countryCode.toString().replaceFirst("+", "");
  //               print("New Country selected: " + countryCode.toString());
  //               countryName = countryCode.name;
  //             },
  //             onInit: (code) {
  //               print("on init ${code!.name} ${code.dialCode} ${code.name}");
  //               countrycode = code.toString().replaceFirst("+", "");
  //               print("New Country selected: " + code.toString());
  //             }),
  //       ));
  // }

  // Widget _buildCountryPicker(CountryCode? country) => Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         new Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: new Image.asset(
  //               country!.flagUri!,
  //               package: 'country_code_picker',
  //               height: 40,
  //               width: 20,
  //             ),
  //           ),
  //         ),
  //         new Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: new Text(
  //               country.dialCode!,
  //               style: TextStyle(fontSize: 12),
  //             ),
  //           ),
  //         ),
  //         new Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: new Text(
  //               country.name!,
  //               maxLines: 3,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         ),
  //       ],
  //     );

  setMobileNo() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: mobileController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        // onSaved: (String? value) {
        //   mobileUser = value;
        //   mobile = mobileUser;
        //   print('Mobile no:$mobile');
        // },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.call_outlined,
            ),
            hintText: "Số điện thoại",
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setPass() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
        onSaved: (String? value) {
          password = value;
          // print(password);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: "Mật Khẩu",
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  forgetPass() {
    return Padding(
        padding:
            EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HappyShopForgotPassword()));
              },
              child: Text("Quên mật khẩu?",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: lightblack)),
            ),
          ],
        ));
  }

  accSignup() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bạn muốn tạo một tài khoản?",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: lightblack2, fontWeight: FontWeight.normal)),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HappyShopSingUp()));
              },
              child: Text(
                "Đăng Ký",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: primary, decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }

  loginBtn() {
    return AppBtn(
      title: "Đăng nhập",
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        validateAndSubmit();
      },
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      validatanmation();
    }
  }
}
