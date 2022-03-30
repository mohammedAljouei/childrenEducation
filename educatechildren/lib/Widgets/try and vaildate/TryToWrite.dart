// ignore_for_file: file_names, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:educatechildren/constants.dart';

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

    return Stack(
      children: [
        Center(
          child: Container(
              width: width / 1.2,
              margin: const EdgeInsets.only(
                  bottom: 200, right: 10, left: 10, top: 60),
              child: Container(
                width: 400,
                height: 400,
                child: ImagePainter.asset(
                  "assets/images/trying/$charId.jpg",
                  key: _imageKey,
                  scalable: true,
                  initialStrokeWidth: 20,
                  initialColor: Colors.black,
                  initialPaintMode: PaintMode.freeStyle,
                ),
              )),
        ),
      ],
    );
  }
}
