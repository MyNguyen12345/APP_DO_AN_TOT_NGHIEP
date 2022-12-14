import 'package:flutter/material.dart';

class HappShopAdminUser extends StatefulWidget {
  @override
  _HappShopAdminUser createState() => _HappShopAdminUser();
}

class _HappShopAdminUser extends State<HappShopAdminUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text('Quản lý người dùng'),
          ),
          body: ListView(children: <Widget>[
            Center(
                child: Text(
              'Danh sách người dùng',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            )),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 10,
                  dataRowHeight: 60,
                  columns: [
                    DataColumn(
                        label: Text('STT',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Ảnh đại diện',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Họ tên',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Số điện thoại',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Địa chỉ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Ngày sinh',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Giới tính',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                    DataColumn(
                        label: Text('Hoạt động',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://happyshop1233.herokuapp.com/images/hinh-dai-dien-nam.jpeg",
                              fit: BoxFit.cover),
                        ),
                      )),
                      DataCell(Text('Cao anh ')),
                      DataCell(Text('2345')),
                      DataCell(Text('Lê Lợi - Đà Nẵng')),
                      DataCell(Text('07/09/2000')),
                      DataCell(Text('Nam')),
                      DataCell(Text('Hoạt động')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://happyshop1233.herokuapp.com/images/avt-cute.jpeg",
                              fit: BoxFit.cover),
                        ),
                      )),
                      DataCell(Text('Nguyễn Văn B')),
                      DataCell(Text('1234')),
                      DataCell(Text('Nguyễn Lương Bằng ')),
                      DataCell(Text('07/09/2000')),
                      DataCell(Text('Nam')),
                      DataCell(Text('Hoạt động')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('3')),
                      DataCell(ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://happyshop1233.herokuapp.com/images/anh-dai-dien-baby-cute_052907875.jpeg",
                              fit: BoxFit.cover),
                        ),
                      )),
                      DataCell(Text('Phan kiết')),
                      DataCell(Text('1234567')),
                      DataCell(Text('Đại Đồng - Quảng Nam')),
                      DataCell(Text('07/09/2000')),
                      DataCell(Text('Nam')),
                      DataCell(Text('Hoạt động')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('4')),
                      DataCell(ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                              "https://happyshop1233.herokuapp.com/images/lovepik-beauty-avatar-png-image_401278240_wh1200.png",
                              fit: BoxFit.cover),
                        ),
                      )),
                      DataCell(Text('Tú khuyên')),
                      DataCell(Text('132')),
                      DataCell(Text('07/09/2000')),
                      DataCell(Text('Huế')),
                      DataCell(Text('Nam')),
                      DataCell(Text('Hoạt động')),
                    ]),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
