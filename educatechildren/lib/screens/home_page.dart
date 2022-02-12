import 'dart:ui';
import 'package:educatechildren/constants.dart';
import 'package:educatechildren/screens/letters/letters_screen.dart';
import 'package:flutter/material.dart';

import 'numbers/numbers_screen.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<ScaffoldState> _glogalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _glogalKey,
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(),
          ],
        ),
      ),
      backgroundColor: kPrimaryBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 60, right: 30, left: 30, bottom: 20),
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
                        icon: Icon(
                          Icons.menu,
                          size: 40,
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                      Expanded(child: Container()),
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 28,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/boy.jpg'),
                            radius: 25,
                          ),
                        ),
                        // child: Image(
                        //   image: AssetImage("assets/images/girl.jpg"),
                        //   fit: BoxFit.fill,
                        // ),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(40),
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'أهلا صديقنا',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    'عبدالرحمن',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NumbersScreen(),
                            ),
                          );
                        },
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              "assets/images/Arabic numbers1.png",
                            ),
                          ),
                          height: MediaQuery.of(context).size.height / 4.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.teal[200]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LettersScreen(),
                            ),
                          );
                        },
                        child: Container(
                          child: Image.asset("assets/images/alphabet1.png"),
                          margin: const EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height / 4.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.teal[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
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
            // color: Colors.black,
            margin: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/61 Children S Day Balloons Children.jpg",
            ),
          )
        ],
      ),
    );
  }
}
