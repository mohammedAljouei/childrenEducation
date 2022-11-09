//ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:educatechildren/constants.dart';

class ValidatePronunciation extends StatelessWidget {
  final int charId;
  final void Function()? increaseOrginIndex;
  ValidatePronunciation(this.charId, this.increaseOrginIndex);

  @override
  Widget build(BuildContext context) {
    return SpeechScreen(charId, increaseOrginIndex);
  }
}

class SpeechScreen extends StatefulWidget {
  final int charId;
  final void Function()? increaseOrginIndex;
  SpeechScreen(this.charId, this.increaseOrginIndex);

  @override
  // ignore: no_logic_in_create_state
  _SpeechScreenState createState() =>
      _SpeechScreenState(charId, increaseOrginIndex);
}

class _SpeechScreenState extends State<SpeechScreen> {
  final charId;
  final void Function()? increaseOrginIndex;
  _SpeechScreenState(this.charId, this.increaseOrginIndex);

  List<String> chars = [
    "صفر",
    "واحد",
    "اث",
    "ثلاثة",
    "أربعة",
    "خمسة",
    "ستة",
    "سبعة",
    "ثمانية",
    "تسعة",
    "1000",
    "ب",
    "ت",
    "ث",
    "ج",
    "ح",
    "خ",
    "د",
    "ذ",
    "ر",
    "ز",
    "س",
    "ش",
    "ص",
    "ض",
    "ط",
    "ض", // not ظ
    "ع",
    "غ",
    "ف",
    "ق",
    "ك",
    "ل",
    "م",
    "نون",
    "ه",
    "و",
    "يا",
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
    "assets/images/alphabet/1.png",
    "assets/images/alphabet/2.png",
    "assets/images/alphabet/3.png",
    "assets/images/alphabet/4.png",
    "assets/images/alphabet/5.png",
    "assets/images/alphabet/6.png",
    "assets/images/alphabet/7.png",
    "assets/images/alphabet/8.png",
    "assets/images/alphabet/9.png",
    "assets/images/alphabet/10.png",
    "assets/images/alphabet/11.png",
    "assets/images/alphabet/12.png",
    "assets/images/alphabet/13.png",
    "assets/images/alphabet/14.png",
    "assets/images/alphabet/15.png",
    "assets/images/alphabet/16.png",
    "assets/images/alphabet/17.png",
    "assets/images/alphabet/18.png",
    "assets/images/alphabet/19.png",
    "assets/images/alphabet/20.png",
    "assets/images/alphabet/21.png",
    "assets/images/alphabet/22.png",
    "assets/images/alphabet/23.png",
    "assets/images/alphabet/24.png",
    "assets/images/alphabet/25.png",
    "assets/images/alphabet/26.png",
    "assets/images/alphabet/27.png",
    "assets/images/alphabet/28.png",
  ];

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
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          // margin: const EdgeInsets.only(top: 100, right: 50, left: 50),
          // padding: const EdgeInsets.only(bottom: 15),
          height: hieght / 3.2,
          width: width,
          child: Image.asset(
            charsUrls[charId],
            fit: BoxFit.contain,
            // alignment: Alignment(0, -1),
          ),
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: Center(
              child: charId > 9
                  ? Text(
                      'أنطق الحرف',
                      style: GoogleFonts.cairo(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'أنطق الرقم',
                      style: GoogleFonts.cairo(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: Center(
            child: AvatarGlow(
              animate: _isListening,
              glowColor: Theme.of(context).primaryColor,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                onPressed: () => _listen(),
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                ),
                backgroundColor: kSecondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print(val),
        onError: (val) => print(val),
      );

      if (available) {
        var locales = await _speech.locales();

        var selectedLocale = locales[0].localeId;

        setState(() => _isListening = true);

        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            var arr = _text.codeUnits;
            var arr2 = chars[charId].codeUnits;
            print(_text);
            print(arr);
            print(chars[charId].codeUnits);

            //val.recognizedWords.codeUnits[1] == char.codeUnits[0]
            // newText == chars[charId] || _text == chars[charId]

            if (_text.contains(chars[charId])) {
              setState(() => _isListening = false);
              _speech.stop();
              once();
              print('good');
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

  int check = 0;

  void once() {
    if (check < 2) {
      increaseOrginIndex!();
      check++;
    }
  }
}
