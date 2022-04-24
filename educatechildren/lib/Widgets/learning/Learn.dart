// ignore_for_file: file_names

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Learn extends StatefulWidget {
  final index;
  Learn(this.index);
  @override
  LearnState createState() => LearnState(index);
}

class LearnState extends State<Learn> {
  late VideoPlayerController _controller;
  final index;
  LearnState(this.index);

  final letVid = [
    'assets/videos/numbers/0.mp4',
    'assets/videos/numbers/1.mp4',
    'assets/videos/numbers/2.mp4',
    'assets/videos/numbers/3.mp4',
    'assets/videos/numbers/4.mp4',
    'assets/videos/numbers/5.mp4',
    'assets/videos/numbers/6.mp4',
    'assets/videos/numbers/7.mp4',
    'assets/videos/numbers/8.mp4',
    'assets/videos/numbers/9.mp4',
    'assets/videos/letters/10.mp4',
    'assets/videos/letters/11.mp4',
    'assets/videos/letters/12.mp4',
    'assets/videos/letters/13.mp4',
    'assets/videos/letters/14.mp4',
    'assets/videos/letters/15.mp4',
    'assets/videos/letters/16.mp4',
    'assets/videos/letters/17.mp4',
    'assets/videos/letters/18.mp4',
    'assets/videos/letters/19.mp4',
    'assets/videos/letters/20.mp4',
    'assets/videos/letters/21.mp4',
    'assets/videos/letters/22.mp4',
    'assets/videos/letters/23.mp4',
    'assets/videos/letters/24.mp4',
    'assets/videos/letters/25.mp4',
    'assets/videos/letters/26.mp4',
    'assets/videos/letters/27.mp4',
    'assets/videos/letters/28.mp4',
    'assets/videos/letters/29.mp4',
    'assets/videos/letters/30.mp4',
    'assets/videos/letters/31.mp4',
    'assets/videos/letters/32.mp4',
    'assets/videos/letters/33.mp4',
    'assets/videos/letters/34.mp4',
    'assets/videos/letters/35.mp4',
    'assets/videos/letters/36.mp4',
    'assets/videos/letters/37.mp4',
  ];

  @override
  void initState() {
    super.initState();
    print(letVid[index]);
    _controller = VideoPlayerController.asset(letVid[index])
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: VideoPlayer(_controller)),
              )
            : Container(),
        Spacer(),
        // SizedBox(
        //   height: 20,
        // ),
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: FloatingActionButton(
            backgroundColor: kSecondaryColor,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
