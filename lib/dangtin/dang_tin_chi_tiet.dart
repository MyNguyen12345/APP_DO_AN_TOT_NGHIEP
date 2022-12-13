import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../Helper/HappyShopColor.dart';

class DangTinScreenChiTiet extends StatefulWidget {
  const DangTinScreenChiTiet({Key? key}) : super(key: key);

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
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text(
              //       "Độ tuổi *",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold, color: Colors.deepOrange),
              //     ),
              //     DropDownTextField(
              //       clearOption: true,
              //       textFieldFocusNode: textFieldFocusNode,
              //       searchFocusNode: searchFocusNode,
              //       searchAutofocus: true,
              //       dropDownItemCount: 8,
              //       searchShowCursor: false,
              //       enableSearch: true,
              //       searchKeyboardType: TextInputType.number,
              //       dropDownList: const [
              //         DropDownValueModel(name: 'name1', value: "value1"),
              //         DropDownValueModel(
              //             name: 'name2',
              //             value: "value2",
              //             toolTipMsg:
              //                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
              //         DropDownValueModel(name: 'name3', value: "value3"),
              //         DropDownValueModel(
              //             name: 'name4',
              //             value: "value4",
              //             toolTipMsg:
              //                 "DropDownButton is a widget that we can use to select one unique value from a set of values"),
              //         DropDownValueModel(name: 'name5', value: "value5"),
              //         DropDownValueModel(name: 'name6', value: "value6"),
              //         DropDownValueModel(name: 'name7', value: "value7"),
              //         DropDownValueModel(name: 'name8', value: "value8"),
              //       ],
              //       onChanged: (val) {},
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
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
              Container(
                margin: const EdgeInsets.all(12),
                height: MediaQuery.of(context).size.height * 0.3,
                child: TextField(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Địa chỉ *",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text('Chọn địa chỉ*'),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )),
                    onTap: () {
                      chondiachibottomshet();
                    },
                  ),
                ],
              ),
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
                onTap: () {},
              )
            ],
          ),
        )),
      ),
    );
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Text(
                              "tỉnh/ thành phố *",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: " Nhập tỉnh hoặc thành phố",
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Text(
                              "Huyện/ quận *",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: " Nhập Quận / huyện",
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Text(
                              "Địa chỉ cụ thể *",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: " Nhập Địa chỉ cụ thể",
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
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
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
                  ),
                ),
              ],
            ),
          );
        });
  }
}
