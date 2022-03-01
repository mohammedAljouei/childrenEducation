// ignore_for_file: file_names, no_logic_in_create_state
import 'dart:io';
import 'package:educatechildren/try%20and%20vaildate/writing/letters/GoodJobWrLett.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:educatechildren/constants.dart';
import 'CheckWrLett.dart';

// ignore: use_key_in_widget_constructors
class ValidateWrLett extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final charId;
  // ignore: use_key_in_widget_constructors
  const ValidateWrLett(this.charId);

  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState(charId);
}

class _ImagePainterExampleState extends State<ValidateWrLett> {
  final charId;
  _ImagePainterExampleState(this.charId);
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

    if (charId == 9 ||
        charId == 25 ||
        charId == 10 ||
        charId == 11 ||
        charId == 12) {
      url = 'https://teachablemachine.withgoogle.com/models/8f2G0-S4B/';
    } else if (charId == 13 ||
        charId == 14 ||
        charId == 16 ||
        charId == 18 ||
        charId == 26) {
      url = 'https://teachablemachine.withgoogle.com/models/HsQ2IxxjT/';
    } else {
      url = 'https://teachablemachine.withgoogle.com/models/Ny0xvNhBg/';
    }

    // if you use a device not a simulator uncomment the comment, and delete GoodJobWrNum(charId)
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              GoodJobWrLett(charId) /*CheckWrLett(charId, _resulte, url)*/),
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
                      "assets/images/black1.png",
                      key: _imageKey,
                      scalable: true,
                      initialStrokeWidth: 2,
                      initialColor: Colors.white,
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

    // Scaffold(
    //   key: _key,
    //   appBar: AppBar(
    //     backgroundColor: const Color(0xFF80CBC4),
    //     actions: [
    //       ElevatedButton(
    //         onPressed: saveImage,
    //         child: const Icon(
    //           Icons.add_task_rounded,
    //           color: Colors.white,
    //           size: 30,
    //         ),
    //         style: ButtonStyle(
    //             backgroundColor:
    //                 MaterialStateProperty.all(const Color(0xFF80CBC4))),
    //       ),
    //     ],
    //   ),
    //   body: _resulte == ''
    //       ? ListView(
    //           children: [
    //             Container(
    //               width: 400,
    //               height: 400,
    //               child: ImagePainter.asset(
    //                 "lib/assets/black1.png",
    //                 key: _imageKey,
    //                 scalable: true,
    //                 initialStrokeWidth: 2,
    //                 initialColor: Colors.white,
    //                 initialPaintMode: PaintMode.freeStyle,
    //               ),
    //             ),
    //             IconButton(
    //               icon: const Icon(
    //                 Icons.directions_transit,
    //               ),
    //               iconSize: 50,
    //               color: Colors.green,
    //               splashColor: Colors.purple,
    //               onPressed: () {},
    //             ),
    //             Container(
    //               // color: Colors.black,
    //               // margin: const EdgeInsets.only(bottom: 15),
    //               // alignment: Alignment.bottomCenter,
    //               child: Image.asset(
    //                 "assets/images/61 Children S Day Balloons Children.jpg",
    //               ),
    //             )
    //           ],
    //         )
    //       : WebView(
    //           initialUrl:
    //               'https://mutamimon.com/myModel/index.php?m=https://teachablemachine.withgoogle.com/models/Ny0xvNhBg/=$_resulte',
    //           javascriptMode: JavascriptMode.unrestricted,
    //           javascriptChannels: {
    //             JavascriptChannel(
    //                 name: 'Print',
    //                 onMessageReceived: (JavascriptMessage message) {
    //                   print(message.message);
    //                   if (message.message == char) {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => const Good()),
    //                     );
    //                   } else {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => const Bad()),
    //                     );
    //                   }
    //                 })
    //           },
    //           onWebViewCreated: (WebViewController webViewController) {
    //             _controller.complete(webViewController);
    //           },
    //         ),
    // );
  }
}
