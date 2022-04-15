// ignore_for_file: deprecated_member_use, file_names

import 'package:educatechildren/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/border_text_field.dart';
import '../Widgets/try and vaildate/TryToWrite.dart';

class UpdateInfo extends StatefulWidget {
  final void Function()? reload;
  const UpdateInfo(this.reload);

  @override
  _UpdateInfoState createState() => _UpdateInfoState(reload);
}

class _UpdateInfoState extends State<UpdateInfo> {
  final void Function()? reload;
  _UpdateInfoState(this.reload);
  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();

  final _storage = FlutterSecureStorage();
  Future getAuthToken() async {
    var token = await _storage.read(key: 'token');
    return token;
  }

  String name = '';
  String title = '';
  var doneLet = '';
  var doneNum = '';
  String imageSelected = '';

  var _token = null;

  void setList(token) async {
    var url =
        "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}/user.json";
    final res = await http.get(Uri.parse(url));
    final body = json.decode(res.body);
    print(body);

    setState(() {
      if (body['gender'] == 0) {
        title = 'أهلا صديقنا';
        imageSelected = "assets/images/boy.jpg";
      } else {
        title = 'أهلا صديقتنا';
        imageSelected = "assets/images/girl2.jpg";
      }
      name = body['name'];
      doneLet = body['doneLet'];
      doneNum = body['doneNum'];
    });
  }

  late FixedExtentScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
    getAuthToken().then((value) => setState(() {
          _token = value;
          setList(_token);
        }));
  }

  final IconData icon = Icons.person;
  final _nameController = TextEditingController();
  String dropdownValue = 'ذكر';
  final items = [
    'ذكر',
    'انثى',
  ];
  int index = 0;

  updateUser(String id) async {
    var gender = 0;
    if (index == 1) {
      gender = 1;
    }

    var url =
        "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${id}.json";
    final res = await http.put(Uri.parse(url),
        body: json.encode({
          "user": {
            "gender": gender,
            "name": _nameController.text,
            "id": id,
            "doneLet": doneLet,
            "doneNum": doneNum
          }
        }));
    final body = json.decode(res.body);
    print(body);
    reload!();
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _glogalKey,
        backgroundColor: kPrimaryBackgroundColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          brightness: Brightness.dark,
          shadowColor: Colors.transparent,
          backgroundColor: kSecondaryColor,
          title: Text(
            "الملف الشخصي",
            style: GoogleFonts.elMessiri(
              fontSize: 20,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: height / 3.4,
              width: width,
              // color: kSecondaryColor,
              decoration: const BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  )),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 80,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        imageSelected,
                      ),
                      radius: 75,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: GoogleFonts.elMessiri(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: EdgeInsets.only(right: 30, top: 30, left: 30),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      child: Text(
                        "الاسم:",
                        style: GoogleFonts.elMessiri(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      width: double.infinity,
                      height: height / 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(169, 176, 185, 0.42),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            // prefixIcon: Icon(icon),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 0.0),
                            border: InputBorder.none,
                            hintText: 'أدخل اسمك الجديد هنا',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromRGBO(169, 176, 185, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: width,
                      child: Text(
                        "الجنس:",
                        style: GoogleFonts.elMessiri(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          // height: height / 15,
                          // padding: EdgeInsets.symmetric(horizontal: 18.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(169, 176, 185, 0.42),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CupertinoButton(
                            child: Text(
                              items[index],
                              style: GoogleFonts.cairo(
                                  fontSize: 20, color: Colors.black),
                            ),
                            onPressed: () {
                              scrollController.dispose();
                              scrollController = FixedExtentScrollController(
                                  initialItem: index);
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  actions: [buildPicker()],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text('الغاء'),
                                    onPressed: () => {Navigator.pop(context)},
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          child: Text(
                            'تحديث',
                            style: GoogleFonts.elMessiri(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () =>
                              {updateUser(_token), Navigator.pop(context)},
                          style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPicker() => SizedBox(
        height: 150,
        child: CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 46,
            onSelectedItemChanged: (index) {
              setState(() {
                this.index = index;

                final item = items[index];
                // ignore: avoid_print
                print("item selected $index");
              });
            },
            children: items
                .map((item) => Center(
                      child: Text(
                        item,
                        style: GoogleFonts.cairo(),
                      ),
                    ))
                .toList()),
      );
}
