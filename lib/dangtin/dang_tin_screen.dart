import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

import '../Helper/HappyShopColor.dart';
import 'dang_tin_chi_tiet.dart';

class DangTinScreen extends StatefulWidget {
  const DangTinScreen({Key? key}) : super(key: key);

  @override
  State<DangTinScreen> createState() => _DangTinScreenState();
}

class _DangTinScreenState extends State<DangTinScreen> {
  List<Asset> images = [];
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();

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
                      const Text('Đăng từ 01 ảnh đến 10 ảnh')
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
                  child: Text(
                    "Tiếp theo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future chondiachibottomshet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
            // MediaQuery.of(context).size.height * 0.9
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Chọn địa chỉ',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "tỉnh/ thành phố *",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ),
                          DropDownTextField(
                            clearOption: true,
                            textFieldFocusNode: textFieldFocusNode,
                            searchFocusNode: searchFocusNode,
                            searchAutofocus: true,
                            dropDownItemCount: 8,
                            searchShowCursor: false,
                            enableSearch: true,
                            searchKeyboardType: TextInputType.number,
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'name1', value: "value1"),
                              DropDownValueModel(
                                  name: 'name2',
                                  value: "value2",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'name3', value: "value3"),
                              DropDownValueModel(
                                  name: 'name4',
                                  value: "value4",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'name5', value: "value5"),
                              DropDownValueModel(
                                  name: 'name6', value: "value6"),
                              DropDownValueModel(
                                  name: 'name7', value: "value7"),
                              DropDownValueModel(
                                  name: 'name8', value: "value8"),
                            ],
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quận/ huyện/ thị xã *",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                          ),
                          DropDownTextField(
                            clearOption: true,
                            textFieldFocusNode: textFieldFocusNode,
                            searchFocusNode: searchFocusNode,
                            searchAutofocus: true,
                            dropDownItemCount: 8,
                            searchShowCursor: false,
                            enableSearch: true,
                            searchKeyboardType: TextInputType.number,
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'name1', value: "value1"),
                              DropDownValueModel(
                                  name: 'name2',
                                  value: "value2",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'name3', value: "value3"),
                              DropDownValueModel(
                                  name: 'name4',
                                  value: "value4",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'name5', value: "value5"),
                              DropDownValueModel(
                                  name: 'name6', value: "value6"),
                              DropDownValueModel(
                                  name: 'name7', value: "value7"),
                              DropDownValueModel(
                                  name: 'name8', value: "value8"),
                            ],
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: " Nhập địa chỉ cụ thể",
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
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
