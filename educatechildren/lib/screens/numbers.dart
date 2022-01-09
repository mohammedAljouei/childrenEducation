// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// هنا تسدح كل الارقام أي رقم يضغط عليه توديه للكمبونينت نمبر عشان يشوف ويسمع الحرف

class Numbers extends StatefulWidget {
  const Numbers({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Numbers> createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
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
