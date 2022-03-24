// ignore_for_file: file_names
import 'dart:math';

import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';

import '../screens/letters/body.dart';
import 'numberQuiz.dart';

class LetterQuiz extends StatefulWidget {
  final int currentNumber;
  const LetterQuiz({required this.currentNumber}) : super();

  @override
  State<LetterQuiz> createState() => _LetterQuizState();
}

class _LetterQuizState extends State<LetterQuiz> {
  bool insideTarget = false;
  var random1 = 0, random2 = 0;
  final dragList = List<int>.filled(3, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    random1 = Random().nextInt(10);
    random2 = Random().nextInt(10);

    while (random1 == random2) {
      random2 = Random().nextInt(10);
    }
    while (random1 == widget.currentNumber) {
      random1 = Random().nextInt(10);
    }
    while (random2 == widget.currentNumber) {
      random2 = Random().nextInt(10);
    }
    dragList[0] = random1;
    dragList[1] = random2;
    dragList[2] = widget.currentNumber;

    dragList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: kPrimaryBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            //margin have to be removed
            margin: const EdgeInsets.only(top: 100),
            height: height / 3,
            width: width / 1.1,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(13),
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/quizFrame.png"),
              //   ),
            ),
            child: DragTarget<int>(
              builder: (context, data, rejectedData) {
                return Container(
                  // height: height / 4,
                  // width: width / 2,
                  child: Image.asset(
                    Body().imagesUrl[widget.currentNumber],
                    height: height,
                    width: width,
                    // fit: BoxFit.cover,
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  if (data == widget.currentNumber) {
                    insideTarget = true;
                  }
                });
              },
            ),
          ),
          Text('result ${insideTarget}'),
          SizedBox(
            height: height / 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DraggableNumber(
                Body().imagesUrl[dragList[0]],
                dragList[0],
              ),
              DraggableNumber(
                Body().imagesUrl[dragList[1]],
                dragList[1],
              ),
              DraggableNumber(
                Body().imagesUrl[dragList[2]],
                dragList[2],
              ),
            ],
          )
        ],
      ),
    );
  }
}



// هنا بتختبر الطفل عن معرفته عن حرف معين سواء زي البالونات او كويز او اي شيء

// اول ما يخلص لاعب وتمشي أموره توديه لصفحة ليتر تراي برو بفولدر التراينق تحت البرونانسييشن عشان ينطق 