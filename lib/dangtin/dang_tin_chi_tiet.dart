import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as GET;
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:dio/dio.dart';
import 'package:smartkit/Screen/HappyShopMyShop.dart';
import 'package:smartkit/controllers/post_controller.dart';
import 'package:smartkit/data/data.dart';
import '../Helper/HappyShopColor.dart';

class DangTinScreenChiTiet extends StatefulWidget {
  DangTinScreenChiTiet({Key? key}) : super(key: key);

  @override
  State<DangTinScreenChiTiet> createState() => _DangTinScreenChiTietState();
}

class _DangTinScreenChiTietState extends State<DangTinScreenChiTiet> {
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  final nameProduct = TextEditingController();
  final price = TextEditingController();
  final deposit = TextEditingController();
  final amount = TextEditingController();
  final status = TextEditingController();
  final descriptionProduct = TextEditingController();
  final tinh = TextEditingController();
  final huyen = TextEditingController();
  final xa = TextEditingController();
  String get productName => nameProduct.text;
  String get priceProduct => price.text;
  String get depositProduct => deposit.text;
  String get amountProduct => amount.text;
  String get productStatus => status.text;
  String get description => descriptionProduct.text;
  String get tinhname => tinh.text;
  String get huyenname => huyen.text;
  String get xaname => xa.text;
  final Data data = GET.Get.put(Data());
  var dio = Dio();
  // final PostController postController = GET.Get.put(PostController());
  final storage = const FlutterSecureStorage();
  Future<void> newPost() async {
    print(data.listImage);
    var avatar = data.listImage[0];
    data.images.removeAt(0);
    data.listImage.removeAt(0);
    List<MultipartFile> listImage = data.listImage;
    var userId = await storage.read(key: 'userId');
    FormData form = FormData.fromMap({
      'user_id': int.parse(userId!),
      'post_status': "cho",
      'category_detail_id': data.categoryDetailId,
      'product_name': productName,
      'product_status': productStatus,
      'avatar': avatar,
      'description': description,
      'amount_product': int.parse(amountProduct),
      'price_product': double.parse(priceProduct),
      'price_deposit': double.parse(depositProduct),
      'list_image': listImage
    });
    var response =
        await dio.post("https://happyshop1233.herokuapp.com/post", data: form);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HappyShopMyShop(
                  appbar: true,
                )),
      );
    } else {
      Text("Đăng tin không thành công ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng tin'),
        leading: InkWell(
          child: const Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepOrange[500],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: nameProduct,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Tên vật phẩm',
                  hintStyle: const TextStyle(color: Colors.deepOrange),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Giá tiền VNĐ',
                  hintStyle: const TextStyle(color: Colors.deepOrange),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: deposit,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Phần trăm khuyến mãi %',
                  hintStyle: const TextStyle(color: Colors.deepOrange),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: amount,
                decoration: InputDecoration(
                  hintText: 'Số lượng',
                  hintStyle: const TextStyle(color: Colors.deepOrange),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                controller: status,
                decoration: InputDecoration(
                  hintText: 'Trạng thái vật phẩm',
                  hintStyle: const TextStyle(color: Colors.deepOrange),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height * 0.3,
                child: TextFormField(
                  controller: descriptionProduct,
                  maxLines: 20,
                  decoration: InputDecoration(
                    hintText: " Nhập mô tả chi tiết",
                    hintStyle: const TextStyle(color: Colors.deepOrange),
                    fillColor: Colors.grey[300],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      // borderSide: BorderSide(
                      //   width: 0,
                      //   style: BorderStyle.none,
                      // ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text(
              //       "Địa chỉ *",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold, color: Colors.deepOrange),
              //     ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     // InkWell(
              //     //   child: Container(
              //     //       decoration: BoxDecoration(
              //     //           border: Border.all(color: Colors.grey)),
              //     //       child: Padding(
              //     //         padding: const EdgeInsets.all(8.0),
              //     //         child: Row(
              //     //           // ignore: prefer_const_literals_to_create_immutables
              //     //           children: [
              //     //             const Text('Chọn địa chỉ*'),
              //     //             const Spacer(),
              //     //             const Icon(Icons.arrow_drop_down)
              //     //           ],
              //     //         ),
              //     //       )),
              //     //   onTap: () {
              //     //     chondiachibottomshet();
              //     //   },
              //     // ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'ĐĂNG TIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  newPost();
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  // Future chondiachibottomshet() {
  //   return showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //       context: context,
  //       builder: (context) {
  //         return SizedBox(
  //           // MediaQuery.of(context).size.height * 0.9
  //           height: MediaQuery.of(context).size.height,
  //           child: Column(
  //             children: [
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               const Text(
  //                 'Chọn địa chỉ',
  //                 style: TextStyle(
  //                     color: Colors.deepOrange,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Row(
  //                         children: [
  //                           const Text(
  //                             "tỉnh/ thành phố *",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.deepOrange),
  //                           ),
  //                           Spacer(),
  //                           SizedBox(
  //                             width: 10,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     TextFormField(
  //                       maxLines: 1,
  //                       controller: tinh,
  //                       decoration: InputDecoration(
  //                         hintText: " Nhập tỉnh hoặc thành phố",
  //                         hintStyle: const TextStyle(color: Colors.deepOrange),
  //                         fillColor: Colors.grey[300],
  //                         filled: true,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           // borderSide: BorderSide(
  //                           //   width: 0,
  //                           //   style: BorderStyle.none,
  //                           // ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Row(
  //                         children: [
  //                           const Text(
  //                             "Huyện/ quận *",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.deepOrange),
  //                           ),
  //                           Spacer(),
  //                           SizedBox(
  //                             width: 10,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     TextFormField(
  //                       maxLines: 1,
  //                       controller: huyen,
  //                       decoration: InputDecoration(
  //                         hintText: " Nhập Quận / huyện",
  //                         hintStyle: const TextStyle(color: Colors.deepOrange),
  //                         fillColor: Colors.grey[300],
  //                         filled: true,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           // borderSide: BorderSide(
  //                           //   width: 0,
  //                           //   style: BorderStyle.none,
  //                           // ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Row(
  //                         children: [
  //                           const Text(
  //                             "Địa chỉ cụ thể *",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.deepOrange),
  //                           ),
  //                           Spacer(),
  //                           SizedBox(
  //                             width: 10,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     TextFormField(
  //                       maxLines: 1,
  //                       controller: xa,
  //                       decoration: InputDecoration(
  //                         hintText: " Nhập Địa chỉ cụ thể",
  //                         hintStyle: const TextStyle(color: Colors.deepOrange),
  //                         fillColor: Colors.grey[300],
  //                         filled: true,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           // borderSide: BorderSide(
  //                           //   width: 0,
  //                           //   style: BorderStyle.none,
  //                           // ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         Navigator.pop(context);
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(0.0)),
  //                           ),
  //                           primary: Colors.transparent,
  //                           padding: EdgeInsets.all(0.0)),
  //                       child: Ink(
  //                         decoration: BoxDecoration(
  //                           gradient: happyshopgradient,
  //                         ),
  //                         child: Container(
  //                           height: 40.0,
  //                           padding: EdgeInsets.only(left: 15.0, right: 15.0),
  //                           alignment: Alignment.center,
  //                           child: Text(
  //                             "Tiếp theo",
  //                             style: TextStyle(color: Colors.white),
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
