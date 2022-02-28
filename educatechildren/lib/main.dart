// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:educatechildren/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Directionality(
              // add this
              textDirection: TextDirection.rtl, // عربي
              child: TabsScreen(),
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => const homePage(),
      },
    );
  }
}

// ignore: use_key_in_widget_constructors
class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homePage(),
    );
  }
}
