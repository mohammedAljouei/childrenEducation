// ignore_for_file: file_names, no_logic_in_create_state
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import '../../constants.dart';

// ignore: use_key_in_widget_constructors
class ValidateWriting extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final charId;
  final void Function()? increaseOrginIndex;
  final void Function()? decreaseOrginIndex;
  // ignore: use_key_in_widget_constructors
  const ValidateWriting(
      this.charId, this.increaseOrginIndex, this.decreaseOrginIndex);

  @override
  _ImagePainterExampleState createState() =>
      _ImagePainterExampleState(charId, increaseOrginIndex, decreaseOrginIndex);
}

class _ImagePainterExampleState extends State<ValidateWriting> {
  final charId;
  final void Function()? increaseOrginIndex;
  final void Function()? decreaseOrginIndex;

  _ImagePainterExampleState(
      this.charId, this.increaseOrginIndex, this.decreaseOrginIndex);
  var isItDone = false;
  var _good = false;
  var _bad = false;
  var _resulte = '';
  var url = '';
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  upload(File imageFile, String nameOfFile) async {
    // open a bytestream
    var stream = http.ByteStream(imageFile.openRead());
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://mutamimon.com/admin/test.php");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile =
        http.MultipartFile('file', stream, length, filename: imageFile.path);

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    _resulte = nameOfFile;
// after adding 10 for letters
    if (charId == 19 ||
        charId == 35 ||
        charId == 20 ||
        charId == 21 ||
        charId == 22) {
      url = 'https://teachablemachine.withgoogle.com/models/8f2G0-S4B/';
    } else if (charId == 23 ||
        charId == 24 ||
        charId == 26 ||
        charId == 28 ||
        charId == 36) {
      url = 'https://teachablemachine.withgoogle.com/models/HsQ2IxxjT/';
    } else if (charId >= 0 && charId <= 9) {
      // it's a number
      url = 'https://teachablemachine.withgoogle.com/models/M2EnauBBR/';
    } else {
      url = 'https://teachablemachine.withgoogle.com/models/Ny0xvNhBg/';
    }

    setState(() {
      isItDone = true;
    });
  }

  void saveImage() async {
    final image = await _imageKey.currentState!.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File('$fullPath');
    imgFile.writeAsBytesSync(image!);

    String name = fullPath;
    var nameOfFileArr = name.split('/');
    String nameOfFile = nameOfFileArr[nameOfFileArr.length - 1];
    print(nameOfFile);

    upload(imgFile, nameOfFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("", style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () => OpenFile.open("$fullPath"),
              child: Text(
                "Open",
                style: TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> chars = [
    "صفر",
    "واحد",
    "اثنين",
    "ثلاثة",
    "أربعة",
    "خمسة",
    "ستة",
    "سبعة",
    "ثمانية",
    "تسعة",
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
    var char = chars[charId];

    double width = MediaQuery.of(context).size.width;
    var color = charId >= 0 && charId <= 9 ? Colors.black : Colors.white;
    var image = charId >= 0 && charId <= 9
        ? "assets/images/testwhite.png"
        : "assets/images/black1.png";
    return isItDone
        ? Container(
            width: width / 1.2,
            height: 200,
            margin: const EdgeInsets.only(
                bottom: 200, right: 10, left: 10, top: 60),
            child: WebView(
              initialUrl:
                  'https://mutamimon.com/myModel/index.php?m=$url=$_resulte',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      print(message.message);
                      if (message.message == char) {
                        setState(() {
                          isItDone = false;
                          _good = true;
                        });
                        print('jp');
                      } else {
                        setState(() {
                          setState(() {
                            isItDone = false;
                            _bad = true;
                          });
                        });
                      }
                    })
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          )
        : _good
            // ignore: deprecated_member_use
            ? ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.blue;
                  }),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return size 40, otherwise 20
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 40);
                    }
                    return TextStyle(fontSize: 20);
                  }),
                ),
                onPressed: increaseOrginIndex,
                child: const Text('لننطق الحرف'),
              )
            : _bad
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.blue;
                      }),
                      textStyle: MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return size 40, otherwise 20
                        if (states.contains(MaterialState.pressed)) {
                          return TextStyle(fontSize: 40);
                        }
                        return TextStyle(fontSize: 20);
                      }),
                    ),
                    onPressed: decreaseOrginIndex,
                    child: const Text('حاول مرة أخرى'),
                  )
                : Stack(
                    children: [
                      Center(
                        child: Container(
                            width: width / 1.2,
                            margin: const EdgeInsets.only(
                                bottom: 200, right: 10, left: 10, top: 60),
                            child: Container(
                              width: 400,
                              height: 400,
                              child: ImagePainter.asset(
                                image,
                                key: _imageKey,
                                scalable: true,
                                initialStrokeWidth: 2,
                                initialColor: color,
                                initialPaintMode: PaintMode.freeStyle,
                              ),
                            )),
                      ),
                      Center(
                          child: Container(
                        margin: const EdgeInsets.only(
                            top: 300, right: 10, left: 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.gpp_good,
                          ),
                          iconSize: 150,
                          color: kPrimaryColor,
                          splashColor: kPrimaryColor,
                          onPressed: saveImage,
                        ),
                      ))
                    ],
                  );
  }
}
