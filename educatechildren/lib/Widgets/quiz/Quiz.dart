// ignore_for_file: file_names, recursive_getters, duplicate_ignore
import 'dart:math';
import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Quiz extends StatefulWidget {
  final int currentIndex;
  final void Function()? increaseOrginIndex;

  // ignore: use_key_in_widget_constructors
  const Quiz({required this.currentIndex, required this.increaseOrginIndex})
      : super();

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool insideTarget = false;
  var random1 = 0, random2 = 0;
  final dragList = List<int>.filled(3, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.currentIndex > 9) {
      random1 = Random().nextInt(17) + 10;
      random2 = Random().nextInt(17) + 10;

      while (random1 == random2) {
        random2 = Random().nextInt(17) + 10;
      }
      while (random1 == widget.currentIndex) {
        random1 = Random().nextInt(17) + 10;
      }
      while (random2 == widget.currentIndex) {
        random2 = Random().nextInt(17) + 10;
      }
    } else {
      random1 = Random().nextInt(10);
      random2 = Random().nextInt(10);

      while (random1 == random2) {
        random2 = Random().nextInt(10);
      }
      while (random1 == widget.currentIndex) {
        random1 = Random().nextInt(10);
      }
      while (random2 == widget.currentIndex) {
        random2 = Random().nextInt(10);
      }
    }

    dragList[0] = random1;
    dragList[1] = random2;
    dragList[2] = widget.currentIndex;

    dragList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      // color: kPrimaryBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            //margin have to be removed
            // margin: const EdgeInsets.only(top: 100),
            height: height / 4,
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
                    lettersNumbersimagesUrls[widget.currentIndex],
                    height: height,
                    width: width,
                    // fit: BoxFit.cover,
                  ),
                );
              },
              onAccept: (data) {
                if (data == widget.currentIndex) {
                  widget.increaseOrginIndex!();
                }

                setState(() {
                  if (data == widget.currentIndex) {
                    insideTarget = true;
                  }
                });
              },
            ),
          ),
          // Text('result ${insideTarget}'),
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DraggableCharacter(
                lettersNumbersimagesUrls[dragList[0]],
                dragList[0],
              ),
              DraggableCharacter(
                lettersNumbersimagesUrls[dragList[1]],
                dragList[1],
              ),
              DraggableCharacter(
                lettersNumbersimagesUrls[dragList[2]],
                dragList[2],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DraggableCharacter extends StatelessWidget {
  final String image;
  final int currentNumber;

  DraggableCharacter(
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
          height: 100,
          width: 100,
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
