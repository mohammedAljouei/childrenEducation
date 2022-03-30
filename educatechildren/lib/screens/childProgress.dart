// ignore_for_file: file_names, prefer_const_constructors

// هنا بتجيب تقدم الطفل على مستوى الحروف والارقام نطقهم وكتابتهم من الستوريج وتكون قابله للتعديل
import 'package:flutter/material.dart';
import 'package:educatechildren/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class ChildProgress extends StatelessWidget {
  ChildProgress({Key? key}) : super(key: key);
  final _storage = FlutterSecureStorage();
  Future getAuthToken() async {
    var token = await _storage.read(key: 'token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      backgroundColor: kPrimaryBackgroundColor,
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _token = null;
  String doneLet = '';
  String doneNum = '';
  List<String> doneLetList = [];
  List<String> doneNumList = [];

  final _storage = FlutterSecureStorage();
  Future getAuthToken() async {
    var token = await _storage.read(key: 'token');
    return token;
  }

  void setList(token) async {
    var url =
        "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}/user.json";
    final res = await http.get(Uri.parse(url));
    final body = json.decode(res.body);

    doneNum = body['doneNum'];

    doneLet = body['doneLet'];

    setState(() {
      doneNumList = doneNum.split('/');
      doneLetList = doneLet.split('/');

      print(doneLetList.length);
      print(doneNumList.length);
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

  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return doneNumList.isEmpty && doneLetList.isEmpty
        ? Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
              height: 150.0,
              width: 150.0,
            ),
          )
        : Directionality(
            // add this
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _glogalKey,
              backgroundColor: kPrimaryBackgroundColor,
              body: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, right: 30, left: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10.0),
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                  width: 150.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'الــحروف',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                  width: 150.0,
                                ),
                                doneLetList.length == 1 && doneLetList[0] == ''
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          'لم يتعلم طفلك اي حرف',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 20,
                                            value: doneLetList.length / 26,
                                            backgroundColor: Colors.grey,
                                            valueColor: AlwaysStoppedAnimation(
                                                kPrimaryColor),
                                          ),
                                          height: 150.0,
                                          width: 150.0,
                                        ),
                                      ),
                                SizedBox(
                                  height: 15.0,
                                  width: 150.0,
                                ),
                                doneLetList.length == 2 && doneLetList[1] != ''
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          'تعلم طفلك حرف الالف',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )
                                    : doneLetList.length == 1
                                        ? Text('')
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Text(
                                              'تعلم طفلك من حرف الالف الى حرف الـ ${doneLetList[doneLetList.length - 1]}',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                SizedBox(
                                  height: 50.0,
                                  width: 150.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    'الأرقام',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                  width: 150.0,
                                ),
                                doneNumList.length == 1 && doneNumList[0] == ''
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          'لم يتعلم طفلك اي رقم',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 20,
                                            value: doneLetList.length / 10,
                                            backgroundColor: Colors.grey,
                                            valueColor: AlwaysStoppedAnimation(
                                                kPrimaryColor),
                                          ),
                                          height: 150.0,
                                          width: 150.0,
                                        ),
                                      ),
                                SizedBox(
                                  height: 15.0,
                                  width: 150.0,
                                ),
                                doneNumList.length == 1 && doneNumList[0] == ''
                                    ? Text('')
                                    : doneNumList.length == 2 &&
                                            doneNumList[1] != ''
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Text(
                                              'تعلم طفلك رقم صفر',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Text(
                                              'تعلم طفلك من رقم صفر الى رقم ${doneNumList[doneNumList.length - 1]}',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // color: Colors.black,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    "assets/images/61 Children S Day Balloons Children.jpg",
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 70,
                  // ),
                ],
              ),
            ));
  }
}
