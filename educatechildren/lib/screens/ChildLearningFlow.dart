// ignore_for_file: file_names

import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';
import '../../Widgets/learning/Learn.dart';
import '../Widgets/try and vaildate/TryToWrite.dart';
import '../Widgets/try and vaildate/ValidateWriting.dart';
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

  int index = 0;
  @override
  Widget build(BuildContext context) {
    void decreaseIndex() {
      // this funcation used only by ValidateWriting()
      setState(() {
        index = 1;
      });
    }

    void handleNextButton() {
      setState(() {
        index++;
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

    // uncomment below if you use a real device "not simulator"
    // Last Widget (RaisedButton) just an example, you can build a new one
    var list = [
      Learn(id),
      TryToWrite(id),
      // ValidateWriting(id, handleNextButton, decreaseIndex),
      ValidatePronunciation(id, handleNextButton),
      Quiz(currentIndex: id, increaseOrginIndex: handleNextButton),
      RaisedButton(
        onPressed: handleSuccessPerformance,
        color: kPrimaryColor,
        textColor: Colors.white,
        child: const Text('مرحى! لقد تعلمت الحرف'),
      )
    ];
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
                    child: list[index])),
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(90, 70, 50, 30),
              child:
                  // if you use a real device "not simulator" insted of 2 put 3 and 3 put 2
                  index == 2
                      ? FlatButton(
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          child: const Text('تخطي'),
                          onPressed: () => {handleNextButton()},
                        )
                      : index == 3 || index == 4 || index == list.length - 1
                          ? const Text('')
                          : FlatButton(
                              color: kPrimaryColor,
                              textColor: Colors.white,
                              child: const Text('التالي'),
                              onPressed: () => {handleNextButton()},
                            ),
            )
          ],
        ),
      ),
    );
  }
}
