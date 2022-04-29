// ignore_for_file: file_names, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:educatechildren/constants.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class TryToWrite extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final charId;
  // ignore: use_key_in_widget_constructors
  const TryToWrite(this.charId);

  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState(charId);
}

class _ImagePainterExampleState extends State<TryToWrite> {
  final charId;
  _ImagePainterExampleState(this.charId);

  final _imageKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Center(
          child: Container(
              height: height / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: ImagePainter.asset(
                  "assets/images/trying/$charId.jpg",
                  key: _imageKey,
                  scalable: true,
                  initialStrokeWidth: 22,
                  initialColor: Colors.black,
                  initialPaintMode: PaintMode.freeStyle,
                ),
              )),
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: Center(
              child: charId > 9
                  ? Text(
                      'أكتب على الحرف',
                      style: GoogleFonts.cairo(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'أكتب على الرقم',
                      style: GoogleFonts.cairo(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
