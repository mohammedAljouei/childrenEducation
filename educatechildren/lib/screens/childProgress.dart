// ignore_for_file: file_names, prefer_const_constructors

// هنا بتجيب تقدم الطفل على مستوى الحروف والارقام نطقهم وكتابتهم من الستوريج وتكون قابله للتعديل
import 'package:flutter/material.dart';
import 'package:educatechildren/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ChildProgress extends StatelessWidget {
  ChildProgress({Key? key}) : super(key: key);

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
  Future getPerformance() async {
    var doneNum = await _storage.read(key: 'doneNum');
    var doneLet = await _storage.read(key: 'doneLet');
    return [doneNum, doneLet];
  }

  void setPerformance(arr) async {
    doneNum = arr[0];

    doneLet = arr[1];

    setState(() {
      doneNumList = doneNum.split('/');
      doneLetList = doneLet.split('/');
    });
  }

  @override
  void initState() {
    getPerformance().then((value) => setState(() {
          var arr = value;
          setPerformance(arr);
        }));

    super.initState();
  }

  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
              body: Column(
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
                    height: deviceSize.height / 1.35,
                    decoration: BoxDecoration(
                      color: kPrimaryBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: deviceSize.width,
                          // alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            "assets/images/progressImage-removebg-preview.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: deviceSize.width,
                          height: deviceSize.height / 4.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(77, 209, 73, 91),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 20),
                                width: deviceSize.width,
                                child: Text(
                                  ":الحروف",
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.elMessiri(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, right: 20),
                                width: deviceSize.width,
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'أكملت ',
                                        style: GoogleFonts.cairo(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: '${doneLetList.length - 1}',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: ' أحرف من اصل 26',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, right: 20),
                                width: deviceSize.width,
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'الحرف القادم: حرف ',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text:
                                            'ال${nameOfLetters[doneLetList.length - 1]}',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: deviceSize.height / 25,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: LiquidLinearProgressIndicator(
                                  borderRadius: 3.0,
                                  borderWidth: 2.0,
                                  borderColor: Colors.black,
                                  value: (doneLetList.length - 1) / 26,
                                  valueColor: AlwaysStoppedAnimation(
                                      Color.fromARGB(223, 209, 73, 91)),
                                  center: Text(
                                    '${((doneLetList.length - 1) * 100 / 26).round()}%',
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
                        SizedBox(
                          height: deviceSize.height / 71,
                          // was 40 for iphone
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: deviceSize.width,
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            "assets/images/progressImage-removebg-preview.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: deviceSize.width,
                          height: deviceSize.height / 4.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(92, 237, 174, 73),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 20),
                                width: deviceSize.width,
                                child: Text(
                                  ":الأرقام",
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.elMessiri(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, right: 20),
                                width: deviceSize.width,
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'أكملت ',
                                        style: GoogleFonts.cairo(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: '${doneNumList.length - 1}',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: ' أرقام من اصل 10',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0, right: 20),
                                width: deviceSize.width,
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'الرقم القادم:  ',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text:
                                        doneNumList.length == 11 ? 
                                            'لقد أكملت الأرقام':
                                            'رقم ${nameOfNumbers[doneNumList.length - 2]}',
                                        style: GoogleFonts.elMessiri(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: deviceSize.height / 25,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: LiquidLinearProgressIndicator(
                                  borderRadius: 3.0,
                                  borderWidth: 2.0,
                                  borderColor: Colors.black,
                                  value: (doneNumList.length - 1) / 10,
                                  valueColor: AlwaysStoppedAnimation(
                                      Color.fromARGB(209, 227, 156, 43)),
                                  center: Text(
                                    '${((doneNumList.length - 1) * 100 / 10).round()}%',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 77, 54, 17),
                                    ),
                                  ),
                                  direction: Axis.horizontal,
                                  backgroundColor:
                                      Color.fromARGB(122, 237, 174, 73),
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
            ));
  }
}
