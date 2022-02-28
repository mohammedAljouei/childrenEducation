// ignore_for_file: file_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:educatechildren/constants.dart';
import '../../pronunciation/letters/ValidatePro.dart';

class Good extends StatelessWidget {
  final letter;
  // ignore: use_key_in_widget_constructors
  const Good(this.letter);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: Container(
        child: Stack(
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
                margin: const EdgeInsets.only(bottom: 200, right: 10, left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ValidatePro(letter)),
                    );
                  },
                  child: const Text(
                    'لـننطق الحرف!',
                    style: TextStyle(backgroundColor: Color(0xFF80CBC4)),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF80CBC4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
