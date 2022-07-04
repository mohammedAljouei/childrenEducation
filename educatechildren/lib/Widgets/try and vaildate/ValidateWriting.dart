// ignore_for_file: file_names, no_logic_in_create_state
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var _resulte = '';
  var url = '';

  final _imageKey = GlobalKey<ImagePainterState>();

  upload(File imageFile, String nameOfFile) async {
    // open a bytestream
    var stream = http.ByteStream(imageFile.openRead());
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://getvisit.net/save_image.php");

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
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    var char = chars[charId];

    double height = MediaQuery.of(context).size.height;
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
                  'https://getvisit.net/get_predict.php?m=$url=$_resulte',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      print(message.message);
                      if (message.message == char) {
                        setState(() {
                          isItDone = false;
                        });
                        print('jp');
                        increaseOrginIndex!();
                      } else {
                        setState(() {
                          isItDone = false;
                        });

                        decreaseOrginIndex!();
                      }
                    })
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          )
        : Column(
            children: [
              Center(
                child: Container(
                    height: height / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
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
              Divider(
                thickness: 1,
              ),
              Expanded(
                child: Center(
                    child: charId > 9
                        ? Text(
                            'أكتب الحرف',
                            style: GoogleFonts.cairo(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'أكتب الرقم',
                            style: GoogleFonts.cairo(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
              ),
              Divider(
                thickness: 1,
              ),
              Center(
                  child: IconButton(
                icon: const Icon(
                  Icons.check_circle,
                ),
                iconSize: 50,
                color: kSecondaryColor,
                splashColor: kSecondaryColor,
                onPressed: saveImage,
              ))
            ],
          );
  }
}
