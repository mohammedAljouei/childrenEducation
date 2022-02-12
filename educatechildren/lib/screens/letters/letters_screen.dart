// ignore_for_file: prefer_const_constructors

import 'package:educatechildren/screens/letters/body.dart';
import 'package:flutter/material.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
