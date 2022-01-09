// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// هنا تسدح كل الحروف أي حرف يضغط عليه توديه للكمبونينت ليتر عشان يشوف ويسمع الحرف
class Letters extends StatefulWidget {
  const Letters({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Letters> createState() => _LettersState();
}

class _LettersState extends State<Letters> {
  // ignore: unused_field
  int _counter = 0;

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEBD8FF),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Text(''));
  }
}
