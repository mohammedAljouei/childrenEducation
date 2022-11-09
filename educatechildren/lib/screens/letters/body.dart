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
    "assets/images/alphabet/1.png",
    "assets/images/alphabet/2.png",
    "assets/images/alphabet/3.png",
    "assets/images/alphabet/4.png",
    "assets/images/alphabet/5.png",
    "assets/images/alphabet/6.png",
    "assets/images/alphabet/7.png",
    "assets/images/alphabet/8.png",
    "assets/images/alphabet/9.png",
    "assets/images/alphabet/10.png",
    "assets/images/alphabet/11.png",
    "assets/images/alphabet/12.png",
    "assets/images/alphabet/13.png",
    "assets/images/alphabet/14.png",
    "assets/images/alphabet/15.png",
    "assets/images/alphabet/16.png",
    "assets/images/alphabet/17.png",
    "assets/images/alphabet/18.png",
    "assets/images/alphabet/19.png",
    "assets/images/alphabet/20.png",
    "assets/images/alphabet/21.png",
    "assets/images/alphabet/22.png",
    "assets/images/alphabet/23.png",
    "assets/images/alphabet/24.png",
    "assets/images/alphabet/25.png",
    "assets/images/alphabet/26.png",
    "assets/images/alphabet/27.png",
    "assets/images/alphabet/28.png",
  ];

  List<String> lockedImagesUrl = [
    "assets/images/alphabet/1.1.png",
    "assets/images/alphabet/2.2.png",
    "assets/images/alphabet/3.3.png",
    "assets/images/alphabet/4.4.png",
    "assets/images/alphabet/5.5.png",
    "assets/images/alphabet/6.6.png",
    "assets/images/alphabet/7.7.png",
    "assets/images/alphabet/8.8.png",
    "assets/images/alphabet/9.9.png",
    "assets/images/alphabet/10.10.png",
    "assets/images/alphabet/11.11.png",
    "assets/images/alphabet/12.12.png",
    "assets/images/alphabet/13.13.png",
    "assets/images/alphabet/14.14.png",
    "assets/images/alphabet/15.15.png",
    "assets/images/alphabet/16.16.png",
    "assets/images/alphabet/17.17.png",
    "assets/images/alphabet/18.18.png",
    "assets/images/alphabet/19.19.png",
    "assets/images/alphabet/20.20.png",
    "assets/images/alphabet/21.21.png",
    "assets/images/alphabet/22.22.png",
    "assets/images/alphabet/23.23.png",
    "assets/images/alphabet/24.24.png",
    "assets/images/alphabet/25.25.png",
    "assets/images/alphabet/26.26.png",
    "assets/images/alphabet/27.27.png",
    "assets/images/alphabet/28.28.png",
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
