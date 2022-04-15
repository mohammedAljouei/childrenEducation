import 'package:flutter/material.dart';
import '../ChildLearningFlow.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  var imagesUrl = {
    0: "assets/images/numbers/Arabic_numbers_0.png",
    1: "assets/images/numbers/Arabic_numbers_1.png",
    2: "assets/images/numbers/Arabic_numbers_2.png",
    3: "assets/images/numbers/Arabic_numbers_3.png",
    4: "assets/images/numbers/Arabic_numbers__4.png",
    5: "assets/images/numbers/Arabic_numbers__5.png",
    6: "assets/images/numbers/Arabic_numbers__6.png",
    7: "assets/images/numbers/Arabic_numbers__7.png",
    8: "assets/images/numbers/Arabic_numbers_8.png",
    9: "assets/images/numbers/Arabic_numbers_9.png",
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
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
            margin: const EdgeInsets.only(bottom: 120, right: 10, left: 10),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 50,
              crossAxisSpacing: 10,
              reverse: true,
              children: [
                for (var i = 0; i < imagesUrl.length; i++)
                  numberWidget(
                    image: imagesUrl[i]!,
                    rotate: i % 2 == 0 ? -0.08 : 0.08,
                    numberId: i,
                  ),
              ],
            ),
          ),
        ),
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
    );
  }
}

class numberWidget extends StatelessWidget {
  const numberWidget({
    Key? key,
    required this.image,
    required this.rotate,
    required this.numberId,
  }) : super(key: key);

  final String image;
  final double rotate;
  final int numberId;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: new Matrix4.rotationZ(rotate),
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChildFlow(numberId)),
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
