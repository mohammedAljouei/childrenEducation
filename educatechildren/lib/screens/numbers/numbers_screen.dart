// ignore_for_file: prefer_const_constructors

import 'package:educatechildren/constants.dart';
import 'package:educatechildren/screens/numbers/body.dart';
import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      backgroundColor: kPrimaryBackgroundColor,
    );
  }
}
