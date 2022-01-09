// ignore_for_file: file_names, prefer_const_constructors

// هنا بتجيب تقدم الطفل على مستوى الحروف والارقام نطقهم وكتابتهم من الستوريج وتكون قابله للتعديل
import 'package:flutter/material.dart';

class ChildProgress extends StatelessWidget {
  const ChildProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // add this
      textDirection: TextDirection.rtl, // عربي
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'ارجع',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
