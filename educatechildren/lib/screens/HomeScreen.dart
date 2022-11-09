// ignore_for_file: prefer_final_fields, file_names

import 'package:educatechildren/constants.dart';
import 'package:educatechildren/screens/letters/letters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'numbers/numbers_screen.dart';
import 'ChildProgress.dart';
import 'Auth.dart';
import 'UpdateInfo.dart';
import 'package:google_fonts/google_fonts.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _storage = const FlutterSecureStorage();

  Future getNameAndGender() async {
    var name1 = await _storage.read(key: 'name');
    var gender1 = await _storage.read(key: 'gender');
    var arr = [name1, gender1];
    return arr;
  }

  String imageSelected = '';

  String name = '';
  String title = '';

  void logout() {
    const _storage = FlutterSecureStorage();
    _storage.deleteAll();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  void reload() {
    getNameAndGender().then((value) {
      setState(() {
        if (value[1] == '0') {
          title = 'أهلا صديقنا';
          imageSelected = "assets/images/boy.jpg";
        } else {
          title = 'أهلا صديقتنا';
          imageSelected = "assets/images/girl2.jpg";
        }
        name = value[0];
      });
    });
  }

  void goToUpdateInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateInfo(reload)),
    );
  }

  void goToProgress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChildProgress()),
    );
  }

  void setInfo(arr) {
    var getName = arr[0];
    var getTitle = '';
    var path = '';

    if (arr[1] == '0') {
      getTitle = 'أهلا صديقنا';
      path = "assets/images/boy.jpg";
    } else {
      getTitle = 'أهلا صديقتنا';
      path = "assets/images/girl2.jpg";
    }

    setState(() {
      name = getName;
      title = getTitle;
      imageSelected = path;
    });
  }

  @override
  void initState() {
    getNameAndGender().then((value) => setState(() {
          var arr = value;
          setInfo(arr);
        }));

    super.initState();
  }

  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl, // عربي
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _glogalKey,
          drawer: Drawer(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 90,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(imageSelected),
                        radius: 70,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  minLeadingWidth: 0,
                  leading: Icon(Icons.thumb_up),
                  title: Text(
                    'تقدم الطفل',
                    style: GoogleFonts.elMessiri(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    goToProgress();
                  },
                ),
                const Divider(),
                ListTile(
                  minLeadingWidth: 0,
                  leading: Icon(Icons.update),
                  title: Text(
                    'تحديث البيانات',
                    style: GoogleFonts.elMessiri(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    goToUpdateInfo();
                  },
                ),
                const Divider(),
                ListTile(
                  minLeadingWidth: 0,
                  leading: Icon(Icons.logout),
                  title: Text(
                    'إعادة تعيين',
                    style: GoogleFonts.elMessiri(
                      fontSize: 17,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    logout();
                  },
                ),
              ],
            ),
          ),
          backgroundColor: kPrimaryBackgroundColor,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 60, right: 30, left: 30, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _glogalKey.currentState!.openDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                size: 40,
                                color: kSecondaryColor,
                              ),
                              padding: const EdgeInsets.all(0),
                            ),
                            Expanded(child: Container()),
                            Container(
                              child: CircleAvatar(
                                backgroundColor: kSecondaryColor,
                                radius: 28,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(imageSelected),
                                  radius: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        title,
                        style: GoogleFonts.elMessiri(
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          name,
                          style: GoogleFonts.elMessiri(
                              textStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NumbersScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      transform: Matrix4.rotationZ(-0.1),
                                      child: Image.asset(
                                        "assets/images/numbers/Arabic_numbers_3.png",
                                        scale: 3.7,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 9),
                                      padding: const EdgeInsets.all(40),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 114, 114, 114)
                                                  .withOpacity(0.5),
                                              spreadRadius: 10,
                                              blurRadius: 10,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: const Color(0xffedae49)),
                                      child: Text(
                                        "الارقام",
                                        style: GoogleFonts.lemonada(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: height / 4.5,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: kSecondaryColor),
                              ),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LettersScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 9),
                                      padding: const EdgeInsets.all(40),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 114, 114, 114)
                                                  .withOpacity(0.5),
                                              spreadRadius: 10,
                                              blurRadius: 10,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: const Color(0xffd1495b)),
                                      child: Text(
                                        "الحروف",
                                        style: GoogleFonts.lemonada(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      transform: Matrix4.rotationZ(-0.1),
                                      child: Image.asset(
                                        "assets/images/1.png",
                                        scale: 3.7,
                                      ),
                                    ),
                                  ],
                                ),
                                height: height / 4.5,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: kSecondaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 70,
                // ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: width,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/61_Children_S_Day_Balloons_Children-re.png",
                    fit: BoxFit.cover,
                    
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
