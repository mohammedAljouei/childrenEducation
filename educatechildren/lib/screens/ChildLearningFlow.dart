// ignore_for_file: file_names

import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/learning/Learn.dart';
import '../Widgets/try and vaildate/TryToWrite.dart';
import '../Widgets/try and vaildate/ValidateWriting.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Widgets/try and vaildate/ValidatePronunciation.dart';
import '../Widgets/quiz/Quiz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      _controller.animateToPage(--index,
          duration: Duration(milliseconds: 333), curve: Curves.bounceInOut);
    });
  }

  void handleNextButton() {
    setState(() {
      _controller.animateToPage(++index,
          duration: Duration(milliseconds: 333), curve: Curves.bounceInOut);
    });
  }

  void handleNextButtonPronunciation() {
    setState(() {
      _controller.animateToPage(index++,
          duration: Duration(milliseconds: 333), curve: Curves.bounceInOut);
    });
  }

  void handleSuccessPerformance() async {
    const _storage = FlutterSecureStorage();
    var token = await _storage.read(key: 'token');

    String? pastLetters = await _storage.read(key: 'doneLet');
    String? pastNumbers = await _storage.read(key: 'doneNum');

    int numberOfLearndLetters = pastLetters!.split('/').length;
    int numberOfLearndNumbers = pastNumbers!.split('/').length;

    if (id > 9) {
      if (numberOfLearndLetters - 1 == id - 10 ||
          (pastLetters.split('/').length == 1 && id - 10 == 0)) {
        var index = id - 10;
        await _storage.write(
          key: 'doneLet',
          value: '$pastLetters/${nameOfLetters[index]}',
        );
      }
    } else {
      if (numberOfLearndNumbers - 1 == id ||
          (pastLetters.split('/').length == 1 && id == 0)) {
        await _storage.write(
          key: 'doneNum',
          value: '$pastNumbers/${nameOfNumbers[id]}',
        );
      }
    }

    Navigator.pop(context);
  }

  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        margin: const EdgeInsets.only(top: 80, bottom: 80, left: 20, right: 20),
        // color: Colors.red,
        child: Column(
          children: [
            SmoothPageIndicator(
                controller: _controller,
                count: 6,
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
              height: height / 1.8,
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    index = page;
                  });
                },
                allowImplicitScrolling: true,
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Learn(id),
                  TryToWrite(id),
                  ValidateWriting(id, handleNextButton, decreaseIndex),
                  ValidatePronunciation(id, handleNextButtonPronunciation),
                  Quiz(currentIndex: id, increaseOrginIndex: handleNextButton),
                  Image.asset(
                    "assets/images/Bubert Stock Image and Video Portfolio.jpg",
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 30),
                child: index == 5
                    ? ElevatedButton(
                        onPressed: handleSuccessPerformance,
                        child: id > 9
                            ? const Text('????????! ?????? ?????????? ??????????')
                            : const Text('????????! ?????? ?????????? ??????????'),
                        style: ElevatedButton.styleFrom(
                            primary: kSecondaryColor,
                            textStyle: GoogleFonts.elMessiri(fontSize: 20),
                            side: BorderSide(width: 3, color: kSecondaryColor),
                            minimumSize: Size(200, 80)),
                      )
                    : index == 2 || index == 4
                        ? const Text('')
                        : OutlinedButton(
                            onPressed: () => {
                              _controller.animateToPage(++index,
                                  duration: Duration(milliseconds: 333),
                                  curve: Curves.bounceInOut)
                            },
                            child: const Text('????????????'),
                            style: OutlinedButton.styleFrom(
                                primary: kSecondaryColor,
                                textStyle: GoogleFonts.elMessiri(fontSize: 30),
                                side: BorderSide(
                                    width: 3, color: kSecondaryColor),
                                minimumSize: Size(200, 80)),
                          )),
          ],
        ));
  }
}
