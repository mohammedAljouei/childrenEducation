// ignore_for_file: file_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'Good.dart';
import 'package:educatechildren/constants.dart';

// ignore: use_key_in_widget_constructors
class Check extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final char;
  final re;
  final url;
  // ignore: use_key_in_widget_constructors
  const Check(this.char, this.re, this.url);

  @override
  CheckState createState() => CheckState(char, re, url);
}

class CheckState extends State<Check> {
  final charId;
  final _resulte;
  final url;
  var _bad = true;
  CheckState(this.charId, this._resulte, this.url);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final _key = GlobalKey<ScaffoldState>();

  List<String> chars = [
    "الف",
    "باء",
    "تاء",
    "ثاء",
    "جيم",
    "حاء",
    "خاء",
    "دال",
    "ذال",
    "راء",
    "زاء",
    "سين",
    "شين",
    "صاد",
    "ضاد",
    "طاء",
    "ظاء",
    "عين",
    "غين",
    "فاء",
    "قاف",
    "كاف",
    "لام",
    "ميم",
    "نون",
    "هاء",
    "واو",
    "ياء",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var char = chars[charId];

    return _bad
        ? Scaffold(
            key: _key,
            appBar: AppBar(
              backgroundColor: const Color(0xFF80CBC4),
            ),
            body: WebView(
              initialUrl:
                  'https://mutamimon.com/myModel/index.php?m=$url=$_resulte',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      print(message.message);
                      if (message.message == char) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Good(charId)),
                        );
                      } else {
                        setState(() {
                          _bad = false;
                        });
                      }
                    })
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ))
        : Scaffold(
            backgroundColor: kPrimaryBackgroundColor,
            body: Container(
              child: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/backgroud_letters.png",
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: width / 1.2,
                      margin: const EdgeInsets.only(
                          bottom: 200, right: 10, left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'حــاول مرة أخـرى',
                          style: TextStyle(backgroundColor: Color(0xFF80CBC4)),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF80CBC4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
