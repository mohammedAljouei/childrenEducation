// ignore_for_file: file_names, no_logic_in_create_state
import 'dart:io';
import 'package:educatechildren/try%20and%20vaildate/writing/numbers/GoodJobWrNum.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:educatechildren/constants.dart';
import 'CheckWrNum.dart';

// ignore: use_key_in_widget_constructors
class ValidateWrNum extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final charId;
  // ignore: use_key_in_widget_constructors
  const ValidateWrNum(this.charId);

  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState(charId);
}

class _ImagePainterExampleState extends State<ValidateWrNum> {
  final charId;
  _ImagePainterExampleState(this.charId);
  var _resulte = '';
  var url = 'https://teachablemachine.withgoogle.com/models/M2EnauBBR/';
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

    // if you use a device not a simulator uncomment the comment, and delete GoodJobWrNum(charId)
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              GoodJobWrNum(charId) /*CheckWrNum(charId, _resulte, url)*/),
    );
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  margin:
                      const EdgeInsets.only(bottom: 200, right: 10, left: 10),
                  child: Container(
                    width: 400,
                    height: 400,
                    child: ImagePainter.asset(
                      "assets/images/testwhite.png",
                      key: _imageKey,
                      scalable: true,
                      initialStrokeWidth: 2,
                      initialColor: Colors.black,
                      initialPaintMode: PaintMode.freeStyle,
                    ),
                  )),
            ),
            Center(
                child: Container(
              margin: const EdgeInsets.only(top: 300, right: 10, left: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.gpp_good,
                ),
                iconSize: 150,
                color: Colors.teal[200],
                splashColor: Colors.teal[200],
                onPressed: saveImage,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
