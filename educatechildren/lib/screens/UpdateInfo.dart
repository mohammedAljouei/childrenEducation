// ignore_for_file: deprecated_member_use, file_names

import 'dart:ui';
import 'package:educatechildren/constants.dart';
import 'package:educatechildren/screens/letters/letters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

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
      } else {
        title = 'أهلا صديقتنا';
      }
      name = body['name'];
      doneLet = body['doneLet'];
      doneNum = body['doneNum'];
    });
  }

  @override
  void initState() {
    super.initState();
    getAuthToken().then((value) => setState(() {
          _token = value;
          setList(_token);
        }));
  }

  final IconData icon = Icons.person;
  final _nameController = TextEditingController();
  String dropdownValue = 'ذكر';

  updateUser(String id) async {
    var gender = 0;
    if (dropdownValue == 'أنثى') {
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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        key: _glogalKey,
        backgroundColor: kPrimaryBackgroundColor,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: kSecondaryColor,
          title: Text(
            "الملف الشخصي",
            style: GoogleFonts.elMessiri(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: height / 3,
              width: width,
              color: kSecondaryColor,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 80,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/boy.jpg'),
                      radius: 75,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "ريان",
                      style: GoogleFonts.elMessiri(
                        fontSize: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 60, right: 30, left: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 28,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/boy.jpg'),
                            radius: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          // onChanged: onChanged,
                          // cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              icon,
                              // color: kPrimaryColor,
                            ),
                            hintText: "ناصر ....",
                            border: InputBorder.none,
                          ),
                        ),
                        DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['ذكر', 'أنثى']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    child: const Text(
                                      'تحديث',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => {updateUser(_token)},
                                    style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 70,
            // ),
            Container(
              // color: Colors.black,
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/61 Children S Day Balloons Children.jpg",
              ),
            )
          ],
        ),
      ),
    );
  }
}
