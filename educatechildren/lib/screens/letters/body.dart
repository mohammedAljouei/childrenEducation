import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../ChildLearningFlow.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  String doneLet = '';

  List<String> doneLetList = [];

  final _storage = const FlutterSecureStorage();

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

  List<String> lockedImagesUrl = [
    "assets/images/alphabet/arabic alphabets continued_أ ملون.png",
    "assets/images/alphabet/arabic alphabets continued_برتقال ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_تفاح ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_ثلج ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_جزر ملون_g .png",
    "assets/images/alphabet/arabic alphabets continued_حذاء ملون_g.png",
    "assets/images/alphabet/arabic_alphabets_continued_خس_ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_دب ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_ذرة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_رمان ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_زهرة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_سمكة ملونة_g.png",
    "assets/images/alphabet/arabic alphabets continued_شمس ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_صندوص ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_ضرس ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_طماطم ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_ظرف ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_عصفور ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_غيمة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_فراولة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_قلم ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_كتاب ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_ليمون ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_منظاد ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_نحلة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_هرة ملون_g .png",
    "assets/images/alphabet/arabic alphabets continued_ورقة ملون_g.png",
    "assets/images/alphabet/arabic alphabets continued_يد ملون_g.png",
  ];

  Future getPerformance() async {
    var doneLet = await _storage.read(key: 'doneLet');
    return doneLet;
  }

  void setPerformance(str) {
    doneLet = str;

    setState(() {
      doneLetList = doneLet.split('/');
      print(doneLetList.length);
    });
  }

  @override
  void initState() {
    getPerformance().then((value) => setState(() {
          var str = value;
          setPerformance(str);
        }));

    super.initState();
  }

  void reload() {
    getPerformance().then((value) => setState(() {
          var str = value;
          setPerformance(str);
        }));
  }

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
                  letterWidget(
                    image: doneLetList.length >= i + 1
                        ? imagesUrl[i]
                        : lockedImagesUrl[i],
                    rotate: imagesUrl[i].length % 2 == 0 ? -0.08 : 0.08,
                    letterId: i + 10,
                    reload: reload,
                    allowed: doneLetList.length >= i + 1 ? true : false,
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

class letterWidget extends StatelessWidget {
  const letterWidget({
    Key? key,
    required this.image,
    required this.rotate,
    required this.letterId,
    required this.reload,
    required this.allowed,
  }) : super(key: key);

  final String image;
  final double rotate;
  final int letterId;
  final Function reload;
  final bool allowed;
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.rotationZ(rotate),
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
          onTap: () {
            allowed
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildFlow(letterId)),
                  ).then((data) {
                    reload();
                  })
                : {};
          },
          child: allowed
              ? Image.asset(
                  image,
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -1),
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -1),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/removebg-preview.png',
                    // fit: BoxFit.cover,
                    alignment: const Alignment(0, 0),
                  ),
                )),
    );
  }
}
