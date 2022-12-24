import 'package:flutter/material.dart';

import 'dang_tin_screen.dart';
// import 'home_screen.dart';

class ButtomBar extends StatefulWidget {
  ButtomBar({Key? key}) : super(key: key);

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  int _selectindex = 0;

  final ScrollController _homeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[500],
        title: const Text('demo'),
      ),
      // body: const HomeScreen(),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Theme.of(context).secondaryHeaderColor,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.speaker_notes_outlined),
                    onPressed: () {}),
                const SizedBox(width: 40), // The dummy child
                IconButton(icon: const Icon(Icons.person), onPressed: () {}),
                IconButton(icon: const Icon(Icons.email), onPressed: () {}),
              ],
            ),
          )),
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
            backgroundColor: Colors.deepOrange[500],
            child: const Icon(Icons.add_a_photo_outlined),
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  context: context,
                  builder: (context) {
                    return Container(
                      // MediaQuery.of(context).size.height * 0.9
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Đăng tin',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                // leading: const Icon(Icons.photo),
                                title: const Text(
                                  'Chọn danh mục',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  // danhmucsanphambottomshet();
                                },
                                // trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Bất đống sản'),
                                onTap: () {
                                  // danhmucsanphambottomshet();
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.music_note),
                                title: new Text(' Xe cộ'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.videocam),
                                title: new Text('Đồ điện tử'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              ListTile(
                                leading: new Icon(Icons.share),
                                title: new Text('Thú Cưng'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Future danhmucsanphambottomshet() {
  //   return showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           // MediaQuery.of(context).size.height * 0.9
  //           height: MediaQuery.of(context).size.height,
  //           child: Column(
  //             children: [
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               const Text(
  //                 'Chọn danh mục',
  //                 style: TextStyle(
  //                     color: Colors.deepOrange,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   ListTile(
  //                     leading: const Icon(Icons.photo),
  //                     title: const Text('gà chó mèo...'),
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) =>  DangTinScreen()),
  //                       );
  //                     },
  //                     trailing: Icon(Icons.arrow_forward_ios),
  //                   ),
  //                   ListTile(
  //                     leading: new Icon(Icons.music_note),
  //                     title: new Text(' Xe cộ'),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     trailing: Icon(Icons.arrow_forward_ios),
  //                   ),
  //                   ListTile(
  //                     leading: new Icon(Icons.videocam),
  //                     title: new Text('Đồ điện tử'),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     trailing: Icon(Icons.arrow_forward_ios),
  //                   ),
  //                   ListTile(
  //                     leading: new Icon(Icons.share),
  //                     title: new Text('Thú Cưng'),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     trailing: Icon(Icons.arrow_forward_ios),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
