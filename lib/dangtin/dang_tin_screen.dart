import 'dart:io';

import 'package:dio/dio.dart';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:smartkit/Screen/HappyShopHomeTab.dart';
import 'package:smartkit/data/data.dart';
import '../Helper/HappyShopColor.dart';
import 'dang_tin_chi_tiet.dart';
import 'package:get/get.dart' as GET;

class DangTinScreen extends StatefulWidget {
  DangTinScreen({Key? key}) : super(key: key);

  @override
  State<DangTinScreen> createState() => _DangTinScreenState();
}

class _DangTinScreenState extends State<DangTinScreen> {
  List<Asset> images = [];
  List<MultipartFile> listImage = [];
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  final Data data = GET.Get.put(Data());

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 7,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<void> saveImage() async {
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
          filename: images[i].name, contentType: MediaType('image', 'jpeg'));
      listImage.add(multipartFile);
    }
    data.listImage = listImage;
    data.images = images;
  }

  //  Future upload(File imageFile)async{

  //   //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   //var length = await imageFile.length();
  //   var uri = Uri.parse("http://192.168.1.101/image_upload_php_mysql/upload.php");

  //   var request = http.MultipartRequest("POST",uri);
  //   request.fields['name'] = nameContr.text;

  //   var pic = await http.MultipartFile.fromPath("image", imageFile.path);
  //   //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

  //   request.files.add(pic);
  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print("image uploaded");
  //   }else{
  //     print("uploaded faild");
  //   }

  //   nameContr.text = "";

  // }

  @override
  void initState() {
    super.initState();
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
        body: Column(
          children: [
            InkWell(
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(168, 159, 170, 174),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.deepOrange[500],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Đăng từ 01 ảnh đến 5 ảnh')
                    ]),
                  ),
                ),
              ),
              onTap: (() {
                loadAssets();
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: buildGridView()),
           ElevatedButton(
              onPressed: () async {
                saveImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DangTinScreenChiTiet()),
                );
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
                  child:
                   Text(
                    "Tiếp theo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
           ,
          ],
        ));
  }

  
}
