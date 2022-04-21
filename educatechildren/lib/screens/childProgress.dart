// ignore_for_file: file_names, prefer_const_constructors

// هنا بتجيب تقدم الطفل على مستوى الحروف والارقام نطقهم وكتابتهم من الستوريج وتكون قابله للتعديل
import 'package:flutter/material.dart';
import 'package:educatechildren/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
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

  late AnimationController animationController;

  @override
  void initState() {
    getAuthToken().then((value) => setState(() {
          _token = value;
          setList(_token);
        }));
    animationController = AnimationController(
        vsync: this,
        // duration: Duration(seconds: 20),
        lowerBound: 0,
        upperBound: 26,
        value: doneLetList.length * 1.0);
    animationController.addListener(() {
      setState(() {});
    });

    animationController.repeat();
    super.initState();
    // getAuthToken().then((value) => setState(() {
    //       _token = value;
    //       setList(_token);
    //     }));
  }

  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final percentage = (animationController.value * 26) / 100;

    return doneNumList.isEmpty && doneLetList.isEmpty
        ? Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(kSecondaryColor),
              ),
              height: 150.0,
              width: 150.0,
            ),
          )
        : Directionality(
            // add this
            textDirection: TextDirection.ltr,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: _glogalKey,
              backgroundColor: kSecondaryColor,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                brightness: Brightness.dark,
                shadowColor: Colors.transparent,
                backgroundColor: kSecondaryColor,
                // title: Text(
                //   "تقدم الطفل",
                //   style: GoogleFonts.elMessiri(
                //     fontSize: 20,
                //   ),
                // ),
              ),
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: deviceSize.height / 10,
                    width: deviceSize.width,
                    // color: kSecondaryColor,
                    decoration: const BoxDecoration(
                      color: kSecondaryColor,
                      // borderRadius: BorderRadius.only(
                      //   bottomRight: Radius.circular(40.0),
                      //   bottomLeft: Radius.circular(40.0),
                      // ),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        decoration: BoxDecoration(),
                        width: deviceSize.width,
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "تقدم الطفل",
                          style: GoogleFonts.elMessiri(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: deviceSize.height,
                    decoration: BoxDecoration(
                      color: kPrimaryBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          width: deviceSize.width,
                          height: deviceSize.height / 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(77, 209, 73, 91),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: deviceSize.height / 25,
                                  margin: EdgeInsets.only(top: 40),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: LiquidLinearProgressIndicator(
                                    borderRadius: 3.0,
                                    // borderWidth: 25.0,
                                    // borderColor: kPrimaryBackgroundColor,
                                    value: animationController.value / 100,
                                    valueColor: AlwaysStoppedAnimation(
                                        Color.fromARGB(223, 209, 73, 91)),
                                    center: Text(
                                      '${percentage.toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(210, 53, 13, 18),
                                      ),
                                    ),
                                    direction: Axis.horizontal,
                                    backgroundColor:
                                        Color.fromARGB(97, 171, 88, 99),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                          child: Column(children: <Widget>[
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
                                    padding: const EdgeInsets.only(right: 30),
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
                                    padding: const EdgeInsets.only(right: 30),
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
                                        padding:
                                            const EdgeInsets.only(right: 30),
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
                                    padding: const EdgeInsets.only(right: 30),
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
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                          'تعلم طفلك رقم صفر',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
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

    Path _buildHeartPath() {
      return Path()
        ..moveTo(55, 15)
        ..cubicTo(55, 12, 50, 0, 30, 0)
        ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
        ..cubicTo(0, 55, 20, 77, 55, 95)
        ..cubicTo(90, 77, 110, 55, 110, 37.5)
        ..cubicTo(110, 37.5, 110, 0, 80, 0)
        ..cubicTo(65, 0, 55, 12, 55, 15)
        ..close();
    }
  }
}
