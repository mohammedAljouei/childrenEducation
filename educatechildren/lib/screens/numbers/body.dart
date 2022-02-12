import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  List<String> imagesUrl = [
    "assets/images/numbers/Arabic_numbers_0.png",
    "assets/images/numbers/Arabic_numbers_1.png",
    "assets/images/numbers/Arabic_numbers_2.png",
    "assets/images/numbers/Arabic_numbers_3.png",
    "assets/images/numbers/Arabic_numbers__4.png",
    "assets/images/numbers/Arabic_numbers__5.png",
    "assets/images/numbers/Arabic_numbers__6.png",
    "assets/images/numbers/Arabic_numbers__7.png",
    "assets/images/numbers/Arabic_numbers_8.png",
    "assets/images/numbers/Arabic_numbers_9.png",
  ];
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
                margin: const EdgeInsets.only(bottom: 200, right: 10, left: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 10,
                  reverse: true,
                  children: [
                    for (var i in imagesUrl)
                      numberWidget(
                        image: i,
                        rotate: i.length % 2 == 0 ? -0.08 : 0.08,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class numberWidget extends StatelessWidget {
  const numberWidget({
    Key? key,
    required this.image,
    required this.rotate,
  }) : super(key: key);

  final String image;
  final double rotate;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: new Matrix4.rotationZ(rotate),
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const homePage()),
          );
        },
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          alignment: Alignment(0, -1),
        ),
      ),
    );
  }
}
