import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../ChildLearningFlow.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  String doneNum = '';

  List<String> doneNumList = [];

  final _storage = const FlutterSecureStorage();

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

  var lockedImagesUrl = {
    0: "assets/images/numbers/Arabic_numbers_0.png",
    1: "assets/images/numbers/Arabic_numbers_1_g.png",
    2: "assets/images/numbers/Arabic_numbers_2_g.png",
    3: "assets/images/numbers/Arabic_numbers_3_g.png",
    4: "assets/images/numbers/Arabic_numbers__4_g.png",
    5: "assets/images/numbers/Arabic_numbers__5_g.png",
    6: "assets/images/numbers/Arabic_numbers__6_g.png",
    7: "assets/images/numbers/Arabic_numbers__7_g.png",
    8: "assets/images/numbers/Arabic_numbers_8_g.png",
    9: "assets/images/numbers/Arabic_numbers_9_g.png",
  };

  Future getPerformance() async {
    var doneNum = await _storage.read(key: 'doneNum');
    return doneNum;
  }

  void setPerformance(str) {
    doneNum = str;

    setState(() {
      doneNumList = doneNum.split('/');
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
                  NumberWidget(
                    image: doneNumList.length >= i + 1
                        ? imagesUrl[i]!
                        : lockedImagesUrl[i]!,
                    rotate: imagesUrl[i]!.length % 2 == 0 ? -0.08 : 0.08,
                    numberId: i,
                    reload: reload,
                    allowed: doneNumList.length >= i + 1 ? true : false,
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

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    Key? key,
    required this.image,
    required this.rotate,
    required this.numberId,
    required this.reload,
    required this.allowed,
  }) : super(key: key);

  final String image;
  final double rotate;
  final int numberId;
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
                  MaterialPageRoute(builder: (context) => ChildFlow(numberId)),
                ).then((data) {
                  reload();
                })
              : {};
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
