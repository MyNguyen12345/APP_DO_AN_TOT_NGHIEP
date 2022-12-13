import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/Helper/HappyShopColor.dart';
import 'package:smartkit/Helper/HappyShopString.dart';
import 'package:smartkit/Screen/HappyShopCart.dart';
import 'package:smartkit/Screen/HappyShopTrackOrder.dart';
import 'package:smartkit/controllers/bill_controller.dart';
import 'package:smartkit/controllers/pay_controller.dart';
import 'package:smartkit/controllers/product_detail_controller.dart';
import 'package:smartkit/models/product_detail_model.dart';

import '../controllers/user_controller.dart';
import '../data/data.dart';
import '../widget/HappyShopbtn.dart';
import 'HappyShopHome.dart';

class HappyShopCheckout extends StatefulWidget {
  HappyShopCheckout({Key? key}) : super(key: key);

  @override
  _HappyShopCheckoutState createState() => _HappyShopCheckoutState();
}

class _HappyShopCheckoutState extends State<HappyShopCheckout>
    with TickerProviderStateMixin {
  int _curIndex = 0;
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<Widget> fragments;
  final data = Get.put(Data());
  final UpdateBillController updateBillController =
      Get.put(UpdateBillController());
  final storage = const FlutterSecureStorage();
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();

    fragments = [Delivery(), Address(), Payment()];
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
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

  stepper() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 0 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  " + "Hóa đơn" + "  ",
                    style: TextStyle(color: _curIndex == 0 ? primary : null)),
              ],
            ),
            onTap: () {
              setState(() {
                _curIndex = 0;
              });
            },
          ),
          Expanded(child: Divider()),
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 1 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  " + "Địa chỉ" + "  ",
                    style: TextStyle(color: _curIndex == 1 ? primary : null)),
              ],
            ),
            onTap: () {
              setState(() {
                _curIndex = 1;
              });
            },
          ),
          Expanded(child: Divider()),
          InkWell(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curIndex == 2 ? primary : Colors.grey,
                  ),
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text("  " + "Thanh toán" + "  ",
                    style: TextStyle(color: _curIndex == 2 ? primary : null)),
              ],
            ),
            onTap: () {
              if (_curIndex == 0) {
                setState(() {
                  _curIndex = 1;
                });
              } else
                setState(() {
                  _curIndex = 2;
                });
            },
          ),
        ],
      ),
    );
  }

  Future<void> payBill() async {
    var userId = await storage.read(key: 'userId');
    await updateBillController.updateBill(data.listProductId!, data.listAmount!,
        data.address.value, 1, int.parse(userId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(CHECKOUT, context),
      body: Column(
        children: [
          stepper(),
          Divider(),
          Expanded(child: fragments[_curIndex]),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Tiền" + " : " + " " + data.price.toString() + " " + "VNĐ",
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_curIndex == 0) {
                  setState(() {
                    _curIndex = _curIndex + 1;
                  });
                } else if (_curIndex == 1) {
                  setState(() {
                    _curIndex = _curIndex + 1;
                  });
                } else if (_curIndex == 2) {
                  payBill();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HappyShopTreackOrder()));
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  primary: Colors.transparent,
                  padding: EdgeInsets.all(0.0)),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: happyshopgradient,
                ),
                child: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    _curIndex == 2 ? "Thanh toán" : "Tiếp theo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Delivery extends GetView<ProductDetailController> {
  Delivery();

//   @override
//   State<StatefulWidget> createState() {
//     return StateDelivery();
//   }
// }

// class StateDelivery extends State<Delivery> with TickerProviderStateMixin {
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;
  var data = Get.put(Data());
  final ProductDetailController productDetailController =
      Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut((() => ProductDetailController()));
    getListProduct();
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _deliveryContent(),
      ],
    ));
  }

  Future<void> getListProduct() async {
    await productDetailController.getProductDetail(data.listProductId!);
    print(productDetailController.state!.length);
  }

  _deliveryContent() {
    return controller.obx((state) => SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                      child: Text(
                        "HÓA ĐƠN",
                        // style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ScreenTypeLayout(
                      mobile: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Tên sản phẩm",
                                        style: TextStyle(color: pink),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "SL",
                                        textAlign: TextAlign.end,
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Tiền",
                                        textAlign: TextAlign.end,
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Tổng tiền",
                                        textAlign: TextAlign.end,
                                      )),
                                ],
                              ),
                              Divider(),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      productDetailController.state!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return orderItem(index);
                                  }),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 28, bottom: 8.0, left: 0, right: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Tổng tiền",
                                      style: TextStyle(color: pink),
                                    ),
                                    Spacer(),
                                    Text(data.totalPrice.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 8, bottom: 8),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Khuyến mãi",
                                      style: TextStyle(color: pink),
                                    ),
                                    Spacer(),
                                    Text(data.promotion.toString())
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 0, right: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Còn lại",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .subtitle1!
                                      //     .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      data.price.toString(),
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .subtitle1!
                                      //     .copyWith(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  orderItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Text(
                productDetailController.state![index].productName,
              )),
          Expanded(
              flex: 1,
              child: Text(
                data.listAmount![index].toString(),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 2,
              child: Text(
                productDetailController.state![index].priceProduct.toString(),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 2,
              child: Text(
                (productDetailController.state![index].priceProduct *
                        data.listAmount![index])
                    .toString(),
                textAlign: TextAlign.end,
              )),
        ],
      ),
    );
  }
}

class Address extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAddress();
  }
}

int? selectedAddress;

class StateAddress extends State<Address> with TickerProviderStateMixin {
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;

  final UserController userController = Get.put(UserController());
  final UpdateAddressController updateAddressController =
      Get.put(UpdateAddressController());
  final Data data = Get.put(Data());
  final storage = const FlutterSecureStorage();

  final tinh = TextEditingController();
  final huyen = TextEditingController();
  final xa = TextEditingController();
  final thon = TextEditingController();

  String get tinhUser => tinh.text;
  String get huyenUser => huyen.text;
  String get xaUser => xa.text;
  String get thonUser => thon.text;

  Future<void> updateAddress() async {
    var address = tinhUser + "-" + huyenUser + "-" + xaUser + "-" + thonUser;
    var userId = await storage.read(key: 'userId');
    await updateAddressController.updateAddress(int.parse(userId!), address);
    data.address.value = address;
  }

  @override
  void initState() {
    data.address.value = userController.state!.address;
    super.initState();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: happyshopgradient,
            ),
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      setUserName(),
                      setPincode(),
                      setEmail(),
                      setAddress(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                updateAddress();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: happyshopgradient,
                ),
                child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),

                  // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: Text(
                    "Sửa địa chỉ",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Obx((() => Text(
                data.address.value,
                style: TextStyle(color: Color.fromARGB(255, 167, 11, 11)),
                textAlign: TextAlign.center,
              ))),
        ],
      ),
    );
  }

  setUserName() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: tinh,
        style: Theme.of(this.context)
            .textTheme
            .subtitle1!
            .copyWith(color: darkgrey),
        onChanged: (v) => setState(() {
          // name = v;
        }),
        onSaved: (String? value) {
          // name = value;
        },
        decoration: InputDecoration(
          hintText: "Thành phố/ Tỉnh",
          hintStyle: TextStyle(color: darkgrey),
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

  setPincode() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: huyen,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            // addressC.text = v;
          }),
          onSaved: (String? value) {
            // addressC.text= value!;
          },
          decoration: InputDecoration(
            hintText: "Quận/ Huyện",
            hintStyle: TextStyle(color: darkgrey),
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
          controller: xa,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            // email = v;
          }),
          onSaved: (String? value) {
            // email = value;
          },
          decoration: InputDecoration(
            hintText: "Xã/Đường",
            hintStyle: TextStyle(color: darkgrey),
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

  setAddress() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: thon,
                style: Theme.of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: darkgrey),
                onChanged: (v) => setState(() {
                  // address = v;
                }),
                onSaved: (String? value) {
                  // address = value;
                },
                decoration: InputDecoration(
                  hintText: "Tổ/Trọ/Nhà",
                  hintStyle: TextStyle(color: darkgrey),
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
          ],
        ));
  }
}

class Payment extends GetView<PayController> {
  Payment();

  final PayController payController = Get.put(PayController());

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> listPay() async {
    await payController.listPay();
    print(payController.state!.length);
  }

  List<String> paymentMethodList = [
    COD_LBL,
    PAYPAL_LBL,
    PAYUMONEY_LBL,
    RAZORPAY_LBL,
    PAYSTACK_LBL,
    FLUTTERWAVE_LBL
  ];
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;

  bool? _isUseWallet = false;
  @override
  Widget build(BuildContext context) {
    listPay();
    return controller.obx((state) => Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: ScreenTypeLayout(
            mobile: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Phương Thức Thanh Toán",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: payController.state!.length,
                          itemBuilder: (context, index) {
                            return paymentItem(index);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  var isselect = false;
  var selsectindex = 0;

  // setSnackbar(String msg) {
  //   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
  //     content: new Text(
  //       msg,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(color: Colors.black),
  //     ),
  //     backgroundColor: Colors.white,
  //     elevation: 1.0,
  //   )
  //   );
  // }

  setSelectedRadioTile(int val) {
    // setState(() {
    selectedRadioTile = val;
    // });
  }

  int? selectedRadioTile = 0;
  Widget paymentItem(int index) {
    return controller.obx((state) => RadioListTile(
          value: index,
          groupValue: selectedRadioTile,
          title: Text(
            payController.state![index].payName,
          ),
          // subtitle: Text("Radio 2 Subtitle"),
          onChanged: (dynamic index) {
            selectedRadioTile = index;

            print("Radio Tile pressed $index");
            setSelectedRadioTile(index);
          },
          // activeColor: Colors.red,
          // selected: true,
        ));
  }
}
