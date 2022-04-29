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

// if the child try two times but he can not pronunciate correct then maybe the child has a problem with pronunciation skip him.
  int numberOfBadResulte = 0;

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
    "1000",
    "با",
    "تاء",
    "ث",
    "جيم",
    "حأ",
    "خاء",
    "دال",
    "ذال",
    "ر",
    "ز",
    "سين",
    "شين",
    "صاد",
    "ضاد",
    "طاء",
    "ظاء",
    "عين",
    "غين",
    "فاء",
    "قاف",
    "كاف",
    "لام",
    "ميم",
    "نون",
    "هاء",
    "واو",
    "ياء",
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
    "assets/images/alphabet/arabic alphabets continued_أ ملون.png",
    "assets/images/alphabet/arabic alphabets continued_برتقال ملون.png",
    "assets/images/alphabet/arabic alphabets continued_تفاح ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ثلج ملون.png",
    "assets/images/alphabet/arabic alphabets continued_جزر ملون .png",
    "assets/images/alphabet/arabic alphabets continued_حذاء ملون.png",
    "assets/images/alphabet/arabic_alphabets_continued_خس_ملون.png",
    "assets/images/alphabet/arabic alphabets continued_دب ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ذرة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_رمان ملون.png",
    "assets/images/alphabet/arabic alphabets continued_زهرة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_سمكة ملونة.png",
    "assets/images/alphabet/arabic alphabets continued_شمس ملون.png",
    "assets/images/alphabet/arabic alphabets continued_صندوص ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ضرس ملون.png",
    "assets/images/alphabet/arabic alphabets continued_طماطم ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ظرف ملون.png",
    "assets/images/alphabet/arabic alphabets continued_عصفور ملون.png",
    "assets/images/alphabet/arabic alphabets continued_غيمة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_فراولة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_قلم ملون.png",
    "assets/images/alphabet/arabic alphabets continued_كتاب ملون.png",
    "assets/images/alphabet/arabic alphabets continued_ليمون ملون.png",
    "assets/images/alphabet/arabic alphabets continued_منظاد ملون.png",
    "assets/images/alphabet/arabic alphabets continued_نحلة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_هرة ملون .png",
    "assets/images/alphabet/arabic alphabets continued_ورقة ملون.png",
    "assets/images/alphabet/arabic alphabets continued_يد ملون.png",
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
        )
      ],
    );
  }

  void _listen() async {
    if (numberOfBadResulte >= 4) {
      increaseOrginIndex!();
    }
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

            print(arr);
            print(chars[charId].codeUnits);

            //val.recognizedWords.codeUnits[1] == char.codeUnits[0]
            // newText == chars[charId] || _text == chars[charId]

            if (arr[1] == arr2[0] || arr[2] == arr2[1]) {
              increaseOrginIndex!();
              print('good');

              setState(() => _isListening = false);
              _speech.stop();
            } else {
              setState(() => _isListening = false);
              _speech.stop();
              numberOfBadResulte++;
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
