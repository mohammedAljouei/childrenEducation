// ignore_for_file: file_names, recursive_getters, duplicate_ignore

import 'dart:math';

import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';

import '../screens/numbers/body.dart';

class NumberQuiz extends StatefulWidget {
  final int currentNumber;

  // ignore: use_key_in_widget_constructors
  const NumberQuiz({required this.currentNumber}) : super();

  @override
  State<NumberQuiz> createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz> {
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
              // image: DecorationImage(
              //   image: AssetImage("assets/images/quizFrame.png"),
              // ),
            ),
            child: DragTarget<int>(
              builder: (context, data, rejectedData) {
                return Container(
                  // height: height / 4,
                  // width: width / 2,
                  child: Image.asset(
                    Body().imagesUrl[widget.currentNumber]!,
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
                Body().imagesUrl[dragList[0]]!,
                dragList[0],
              ),
              DraggableNumber(
                Body().imagesUrl[dragList[1]]!,
                dragList[1],
              ),
              DraggableNumber(
                Body().imagesUrl[dragList[2]]!,
                dragList[2],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DraggableNumber extends StatelessWidget {
  final String image;
  final int currentNumber;

  DraggableNumber(
    this.image,
    this.currentNumber,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(13)),
      child: Draggable(
        data: currentNumber,
        child: Container(
          height: 120.0,
          width: 120.0,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            alignment: Alignment(0, -1),
          ),
        ),
        feedback: Container(
          height: 120.0,
          width: 120.0,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            alignment: Alignment(0, -1),
          ),
        ),
        // childWhenDragging: Container(
        //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        //   height: 120.0,
        //   width: 120.0,
        //   // color: kPrimaryBackgroundColor,
        // ),
      ),
    );
  }
}

// اول ما يخلص لاعب وتمشي أموره توديه لصفحة نمبر تراي برو بفولدر التراينق تحت البرونانسييشن عشان ينطق
