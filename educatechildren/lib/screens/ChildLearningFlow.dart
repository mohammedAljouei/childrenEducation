// ignore_for_file: file_names

import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_painter/image_painter.dart';
import '../../Widgets/learning/Learn.dart';
import '../Widgets/try and vaildate/TryToWrite.dart';
import '../Widgets/try and vaildate/ValidateWriting.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Widgets/try and vaildate/ValidatePronunciation.dart';
import '../Widgets/quiz/Quiz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChildFlow extends StatefulWidget {
  final id;
  ChildFlow(this.id);

  @override
  _ChildFlowState createState() => _ChildFlowState(id);
}

class _ChildFlowState extends State<ChildFlow> {
  final id;

  _ChildFlowState(this.id);

  // int index = 0;
  @override
  Widget build(BuildContext context) {
    // void decreaseIndex() {
    //   // this funcation used only by ValidateWriting()
    //   setState(() {
    //     index = 1;
    //   });
    // }

    // void handleNextButton() {
    //   setState(() {
    //     index++;
    //   });
    // }

    // void handleSuccessPerformance() async {
    //   const _storage = FlutterSecureStorage();
    //   var token = await _storage.read(key: 'token');
    //   var urlGetFrom =
    //       "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}/user.json";
    //   final res = await http.get(Uri.parse(urlGetFrom));
    //   final body = json.decode(res.body);

    //   String pastLetters = body['doneLet'];
    //   String pastNumbers = body['doneNum'];
    //   int numberOfLearndLetters = pastLetters.split('/').length;
    //   int numberOfLearndNumbers = pastNumbers.split('/').length;
    //   print(token);
    //   if (id > 9) {
    //     print(numberOfLearndLetters);
    //     print(id);
    //     print(pastLetters.split('/').length);
    //     if (numberOfLearndLetters - 1 == id - 10 ||
    //         (pastLetters.split('/').length == 1 && id - 10 == 0)) {
    //       var index = id - 10;
    //       var urlPostTo =
    //           "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}.json";
    //       await http.put(Uri.parse(urlPostTo),
    //           body: json.encode({
    //             "user": {
    //               "gender": body['gender'],
    //               "name": body['name'],
    //               "id": token,
    //               "doneLet": '$pastLetters/${nameOfLetters[index]}',
    //               "doneNum": pastNumbers
    //             }
    //           }));
    //     }
    //   } else {
    //     print(numberOfLearndNumbers);
    //     print(id);
    //     print(pastLetters.split('/').length);

    //     if (numberOfLearndNumbers - 1 == id ||
    //         (pastLetters.split('/').length == 1 && id == 0)) {
    //       var urlPostTo =
    //           "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}.json";
    //       await http.put(Uri.parse(urlPostTo),
    //           body: json.encode({
    //             "user": {
    //               "gender": body['gender'],
    //               "name": body['name'],
    //               "id": token,
    //               "doneLet": pastLetters,
    //               "doneNum": '$pastNumbers/${nameOfNumbers[id]}'
    //             }
    //           }));
    //     }
    //   }

    //   Navigator.pop(context);
    // }

    // uncomment below if you use a real device "not simulator"
    // Last Widget (RaisedButton) just an example, you can build a new one
    // var list = [
    //   Learn(id),
    //   TryToWrite(id),
    //   // ValidateWriting(id, handleNextButton, decreaseIndex),
    //   ValidatePronunciation(id, handleNextButton),
    //   Quiz(currentIndex: id, increaseOrginIndex: handleNextButton),
    //   ElevatedButton(
    //     onPressed: handleSuccessPerformance,
    //     style: ButtonStyle(
    //       backgroundColor: MaterialStateProperty.resolveWith((states) {
    //         // If the button is pressed, return green, otherwise blue
    //         if (states.contains(MaterialState.pressed)) {
    //           return Colors.green;
    //         }
    //         return Colors.blue;
    //       }),
    //       textStyle: MaterialStateProperty.resolveWith((states) {
    //         // If the button is pressed, return size 40, otherwise 20
    //         if (states.contains(MaterialState.pressed)) {
    //           return TextStyle(fontSize: 40);
    //         }
    //         return TextStyle(fontSize: 20);
    //       }),
    //     ),
    //     child: const Text('مرحى! لقد تعلمت الحرف'),
    //   )
    // ];
    // final _controller = PageController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/backgroud_letters.png",
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Positioned.fill(child: childFlowCard(this.id)),
            // Positioned(
            //     top: 100,
            //     bottom: 200,
            //     child: PageView(
            //       controller: _controller,
            //       children: [
            //         list[0],
            //         list[1],
            //         list[2],
            //         list[3],
            //       ],
            //       // child: Container(
            //       //     color: Colors.red,
            //       //     width: width,
            //       //     height: height,
            //       //     child: list[index]),
            //     )),
            // Positioned(
            //     height: 100,
            //     width: width,
            //     // top: 50,
            //     // right: 20,
            //     // left: 20,
            //     child: SmoothPageIndicator(controller: _controller, count: 4)),
            // Container(
            //   alignment: Alignment.centerRight,
            //   width: double.infinity,
            //   margin: const EdgeInsets.fromLTRB(90, 70, 50, 30),
            //   child:
            //       // if you use a real device "not simulator" insted of 2 put 3 and 3 put 2
            //       index == 2
            //           ? ElevatedButton(
            //               style: ButtonStyle(
            //                 backgroundColor:
            //                     MaterialStateProperty.resolveWith((states) {
            //                   // If the button is pressed, return green, otherwise blue
            //                   if (states.contains(MaterialState.pressed)) {
            //                     return Colors.green;
            //                   }
            //                   return Colors.blue;
            //                 }),
            //                 textStyle:
            //                     MaterialStateProperty.resolveWith((states) {
            //                   // If the button is pressed, return size 40, otherwise 20
            //                   if (states.contains(MaterialState.pressed)) {
            //                     return TextStyle(fontSize: 40);
            //                   }
            //                   return TextStyle(fontSize: 20);
            //                 }),
            //               ),
            //               child: const Text('تخطي'),
            //               onPressed: () => {handleNextButton()},
            //             )
            //           : index == 3 || index == 4 || index == list.length - 1
            //               ? const Text('')
            //               : ElevatedButton(
            //                   style: ButtonStyle(
            //                     backgroundColor:
            //                         MaterialStateProperty.resolveWith((states) {
            //                       // If the button is pressed, return green, otherwise blue
            //                       if (states.contains(MaterialState.pressed)) {
            //                         return Colors.green;
            //                       }
            //                       return Colors.blue;
            //                     }),
            //                     textStyle:
            //                         MaterialStateProperty.resolveWith((states) {
            //                       // If the button is pressed, return size 40, otherwise 20
            //                       if (states.contains(MaterialState.pressed)) {
            //                         return TextStyle(fontSize: 40);
            //                       }
            //                       return TextStyle(fontSize: 20);
            //                     }),
            //                   ),
            //                   child: const Text('التالي'),
            //                   onPressed: () => {handleNextButton()},
            //                 ),
            // ),
            Positioned(
              top: 50,
              left: 5,
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class childFlowCard extends StatefulWidget {
  final id;
  childFlowCard(this.id);

  @override
  State<childFlowCard> createState() => _childFlowCardState(id);
}

class _childFlowCardState extends State<childFlowCard> {
  final id;

  int index = 0;

  _childFlowCardState(this.id);

  void decreaseIndex() {
    // this funcation used only by ValidateWriting()
    setState(() {
      index = 1;
    });
  }

  void handleNextButton() {
    setState(() {
      _controller.animateToPage(++index,
          duration: Duration(milliseconds: 333), curve: Curves.bounceInOut);
    });
  }

  void handleSuccessPerformance() async {
    const _storage = FlutterSecureStorage();
    var token = await _storage.read(key: 'token');
    var urlGetFrom =
        "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}/user.json";
    final res = await http.get(Uri.parse(urlGetFrom));
    final body = json.decode(res.body);

    String pastLetters = body['doneLet'];
    String pastNumbers = body['doneNum'];
    int numberOfLearndLetters = pastLetters.split('/').length;
    int numberOfLearndNumbers = pastNumbers.split('/').length;
    print(token);
    if (id > 9) {
      print(numberOfLearndLetters);
      print(id);
      print(pastLetters.split('/').length);
      if (numberOfLearndLetters - 1 == id - 10 ||
          (pastLetters.split('/').length == 1 && id - 10 == 0)) {
        var index = id - 10;
        var urlPostTo =
            "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}.json";
        await http.put(Uri.parse(urlPostTo),
            body: json.encode({
              "user": {
                "gender": body['gender'],
                "name": body['name'],
                "id": token,
                "doneLet": '$pastLetters/${nameOfLetters[index]}',
                "doneNum": pastNumbers
              }
            }));
      }
    } else {
      print(numberOfLearndNumbers);
      print(id);
      print(pastLetters.split('/').length);

      if (numberOfLearndNumbers - 1 == id ||
          (pastLetters.split('/').length == 1 && id == 0)) {
        var urlPostTo =
            "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${token}.json";
        await http.put(Uri.parse(urlPostTo),
            body: json.encode({
              "user": {
                "gender": body['gender'],
                "name": body['name'],
                "id": token,
                "doneLet": pastLetters,
                "doneNum": '$pastNumbers/${nameOfNumbers[id]}'
              }
            }));
      }
    }

    Navigator.pop(context);
  }

  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // uncomment below if you use a real device "not simulator"
    // Last Widget (RaisedButton) just an example, you can build a new one
    var list = [
      Learn(id),
      TryToWrite(id),
      // ValidateWriting(id, handleNextButton, decreaseIndex),
      ValidatePronunciation(id, handleNextButton),
      Quiz(currentIndex: id, increaseOrginIndex: handleNextButton),
      Image.asset(
        "assets/images/Bubert Stock Image and Video Portfolio.jpg",
        fit: BoxFit.cover,
      ),
      ElevatedButton(
        onPressed: handleSuccessPerformance,
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
        child: const Text('مرحى! لقد تعلمت الحرف'),
      )
    ];
    return Container(
        margin:
            const EdgeInsets.only(top: 80, bottom: 100, left: 30, right: 30),
        // color: Colors.red,
        child: Column(
          children: [
            SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: ExpandingDotsEffect(
                    activeDotColor: kSecondaryColor,
                    dotColor: Color.fromARGB(103, 112, 162, 136))),
            SizedBox(
              height: 30,
            ),
            Container(
              // padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 500,
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    index = page;
                  });
                },
                allowImplicitScrolling: true,
                controller: _controller,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  Learn(id),
                  ValidatePronunciation(id, handleNextButton),
                  Quiz(currentIndex: id, increaseOrginIndex: handleNextButton),
                  Image.asset(
                    "assets/images/Bubert Stock Image and Video Portfolio.jpg",
                    fit: BoxFit.contain,
                  ),
                  // Container(
                  //   height: 50,
                  //   color: Colors.blueAccent,
                  // ),
                  // Container(
                  //   height: 50,
                  //   color: Colors.amber,
                  // ),
                  // Container(
                  //   height: 50,
                  //   color: Colors.blueAccent,
                  // ),
                ],
              ),
            ),
            // Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(30)),
            //     ),
            //     child: list[index]),
            const Spacer(),
            Container(
                alignment: Alignment.bottomRight,
                // color: Colors.red,
                // height: height,
                margin: const EdgeInsets.only(bottom: 30),
                child: index == 3
                    ? ElevatedButton(
                        onPressed: handleSuccessPerformance,
                        child: const Text('مرحى! لقد تعلمت الحرف'),
                        style: ElevatedButton.styleFrom(
                            primary: kSecondaryColor,
                            textStyle: GoogleFonts.elMessiri(fontSize: 20),
                            side: BorderSide(width: 3, color: kSecondaryColor),
                            minimumSize: Size(200, 80)),
                      )
                    : OutlinedButton(
                        onPressed: () => {
                          _controller.animateToPage(++index,
                              duration: Duration(milliseconds: 333),
                              curve: Curves.bounceInOut)
                        },
                        child: const Text('التالي'),
                        style: OutlinedButton.styleFrom(
                            primary: kSecondaryColor,
                            textStyle: GoogleFonts.elMessiri(fontSize: 30),
                            side: BorderSide(width: 3, color: kSecondaryColor),
                            minimumSize: Size(200, 80)),
                      )
                // if you use a real device "not simulator" insted of 2 put 3 and 3 put 2
                // index == 2
                //     ? ElevatedButton(
                //         style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.resolveWith((states) {
                //             // If the button is pressed, return green, otherwise blue
                //             if (states.contains(MaterialState.pressed)) {
                //               return Colors.green;
                //             }
                //             return Colors.blue;
                //           }),
                //           textStyle:
                //               MaterialStateProperty.resolveWith((states) {
                //             // If the button is pressed, return size 40, otherwise 20
                //             if (states.contains(MaterialState.pressed)) {
                //               return TextStyle(fontSize: 40);
                //             }
                //             return TextStyle(fontSize: 20);
                //           }),
                //         ),
                //         child: const Text('تخطي'),
                //         onPressed: () => {handleNextButton()},
                //       )
                //     : index == 3 || index == 4 || index == list.length - 1
                //         ? const Text('')
                //         : ElevatedButton(
                //             style: ButtonStyle(
                //               backgroundColor:
                //                   MaterialStateProperty.resolveWith(
                //                       (states) {
                //                 // If the button is pressed, return green, otherwise blue
                //                 if (states
                //                     .contains(MaterialState.pressed)) {
                //                   return Colors.green;
                //                 }
                //                 return Colors.blue;
                //               }),
                //               textStyle: MaterialStateProperty.resolveWith(
                //                   (states) {
                //                 // If the button is pressed, return size 40, otherwise 20
                //                 if (states
                //                     .contains(MaterialState.pressed)) {
                //                   return TextStyle(fontSize: 40);
                //                 }
                //                 return TextStyle(fontSize: 20);
                //               }),
                //             ),
                //             child: const Text('التالي'),
                //             onPressed: () => {handleNextButton()},
                //           ),
                ),
          ],
        ));
  }
}
