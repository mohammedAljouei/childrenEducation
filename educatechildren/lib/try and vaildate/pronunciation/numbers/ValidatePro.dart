//ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:educatechildren/constants.dart';
import 'Good.dart';

class ValidatePro extends StatelessWidget {
  final int charId;
  ValidatePro(this.charId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeechScreen(charId);
  }
}

class SpeechScreen extends StatefulWidget {
  final int charId;
  SpeechScreen(this.charId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SpeechScreenState createState() => _SpeechScreenState(charId);
}

class _SpeechScreenState extends State<SpeechScreen> {
  final charId;

  _SpeechScreenState(this.charId);

  List<String> chars = [
    "صفر",
    "واحد",
    "اثنين",
    "ثلاثة",
    "أربعة",
    "خمسة",
    "ستة",
    "سبعة",
    "ثمانية",
    "تسعة",
  ];

  List<String> charsUrls = [
    "assets/images/numbers/Arabic_numbers_0.png",
    "assets/images/numbers/Arabic_numbers_1.png",
    "assets/images/numbers/Arabic_numbers_2.png",
    "assets/images/numbers/Arabic_numbers_3.png",
    "assets/images/numbers/Arabic_numbers__4.png",
    "assets/images/numbers/Arabic_numbers__5.png",
    "assets/images/numbers/Arabic_numbers__6.png",
    "assets/images/numbers/Arabic_numbers__7.png",
    "assets/images/numbers/Arabic_numbers_8.png",
    "assets/images/numbers/Arabic_numbers_9.png",
  ];

  // بيكون فيه ليست للحروف حسب المعرف بتختار حرف افرض انه جاك واحد اللي هو حرف باء

  // بتشيك على الليست وبيكون

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '`';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    var char = chars[charId];
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
          ),
          backgroundColor: const Color(0xFF80CBC4),
        ),
      ),
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
            Container(
              margin: const EdgeInsets.only(top: 200, right: 10, left: 10),
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                child: Image.asset(
                  charsUrls[charId],
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _listen() async {
    print('hi');
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print(available);
      if (available) {
        var locales = await _speech.locales();

        // Some UI or other code to select a locale from the list
        // resulting in an index, selectedLocale

        var selectedLocale = locales[0].localeId;

        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            var arr = _text.codeUnits;
            var arr2 = chars[charId].codeUnits;

            print(arr);
            print(chars[charId].codeUnits);

            //val.recognizedWords.codeUnits[1] == char.codeUnits[0]
            // newText == chars[charId] || _text == chars[charId]

            if (arr[1] == arr2[0] || arr[2] == arr2[1]) {
              print('good');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Good()),
              );
              setState(() => _isListening = false);
              _speech.stop();
            } else {
              setState(() => _isListening = false);
              _speech.stop();
            }

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
          localeId: selectedLocale,
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
