import 'package:flutter/material.dart';
import '../ChildLearningFlow.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  List<String> imagesUrl = [
    "assets/images/alphabet/arabic alphabets continued_أ ملون.png",
    "assets/images/alphabet/arabic alphabets continued_برتقال ملون.png",
    "assets/images/alphabet/arabic alphabets continued_تفاح ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ثلج ملون.png",
    "assets/images/alphabet/arabic alphabets continued_جزر ملون .png",
    "assets/images/alphabet/arabic alphabets continued_حذاء ملون.png",
    "assets/images/alphabet/arabic_alphabets_continued_خس_ملون.png",
    "assets/images/alphabet/arabic alphabets continued_دب ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ذرة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_رمان ملون.png",
    "assets/images/alphabet/arabic alphabets continued_زهرة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_سمكة ملونة.png",
    "assets/images/alphabet/arabic alphabets continued_شمس ملون.png",
    "assets/images/alphabet/arabic alphabets continued_صندوص ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ضرس ملون.png",
    "assets/images/alphabet/arabic alphabets continued_طماطم ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ظرف ملون.png",
    "assets/images/alphabet/arabic alphabets continued_عصفور ملون.png",
    "assets/images/alphabet/arabic alphabets continued_غيمة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_فراولة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_قلم ملون.png",
    "assets/images/alphabet/arabic alphabets continued_كتاب ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ليمون ملون.png",
    "assets/images/alphabet/arabic alphabets continued_منظاد ملون.png",
    "assets/images/alphabet/arabic alphabets continued_نحلة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_هرة ملون .png",
    "assets/images/alphabet/arabic alphabets continued_ورقة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_يد ملون.png",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
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
            margin: const EdgeInsets.only(bottom: 200, right: 10, left: 10),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 50,
              crossAxisSpacing: 10,
              reverse: true,
              children: [
                for (var i = 0; i < imagesUrl.length; i++)
                  letterWidget(
                    image: imagesUrl[i],
                    rotate: imagesUrl[i].length % 2 == 0 ? -0.08 : 0.08,
                    letterId: i + 10,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class letterWidget extends StatelessWidget {
  const letterWidget({
    Key? key,
    required this.image,
    required this.rotate,
    required this.letterId,
  }) : super(key: key);

  final String image;
  final double rotate;
  final int letterId;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.rotationZ(rotate),
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChildFlow(letterId)),
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
