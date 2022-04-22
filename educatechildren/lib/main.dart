// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:educatechildren/screens/HomeScreen.dart';
import 'package:educatechildren/screens/authentication.dart';
import 'package:flutter/material.dart';
import 'screens/Auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

final _storage = FlutterSecureStorage();
Future checkAuth() async {
  var token = await _storage.read(key: 'token');
  return token;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _token = null;

  @override
  Widget build(BuildContext context) {
    checkAuth().then((value) => setState(() {
          _token = value;
        }));
    // final _storage = FlutterSecureStorage();
    // _storage.deleteAll();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => Directionality(
              textDirection: TextDirection.rtl, // عربي
              child: _token == null ? Authentication() : TabsScreen(),
            ),
        '/home': (context) => Directionality(
              // add this
              textDirection: TextDirection.rtl, // عربي
              child: homePage(),
            )
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
