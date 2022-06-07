// ignore_for_file: unused_field
//ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'package:educatechildren/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Widgets/input_text_field.dart';
import '../constants.dart';

class AuthScreen extends StatelessWidget {
  // static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryBackgroundColor,
        body: Directionality(
          textDirection: TextDirection.rtl, // عربي
          child: Stack(
            children: <Widget>[
              Image.asset(
                "assets/images/authentication.png",
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
              ),
              AuthCard(),
            ],
          ),
        ));
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  String dropdownValue = 'ذكر';

  final IconData icon = Icons.person;
  String errorMessage = '';
  final _storage = FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _nameController = TextEditingController();

  saveUser(String id) async {
    var gender = 0;
    if (dropdownValue == 'أنثى') {
      gender = 1;
    }

    await _storage.write(
      key: 'name',
      value: _nameController.text,
    );

    await _storage.write(
      // !!
      key: 'gender',
      value: gender.toString(),
    );

    await _storage.write(
      key: 'doneLet',
      value: '',
    );
    await _storage.write(
      key: 'doneNum',
      value: '',
    );
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });

    await _storage.write(
      key: 'token',
      value: 'user',
    );

    await saveUser('user');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => homePage(),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(children: [
        Text(
          'مرحبـا',
          style: GoogleFonts.elMessiri(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline,
              color: kSecondaryColor),
        ),
        SizedBox(
          height: deviceSize.height / 25,
        ),
        Container(
          // height: deviceSize.height / 10,
          // margin: EdgeInsets.symmetric(horizontal: 20),
          // decoration: BoxDecoration(
          //     color: Color.fromARGB(255, 255, 255, 255),
          //     borderRadius: BorderRadius.all(Radius.circular(30)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(255, 163, 163, 163).withOpacity(0.5),
          //         spreadRadius: 3,
          //         blurRadius: 10,
          //       ),
          //     ]),
          // alignment: Alignment(0, 0),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: deviceSize.width,
                  child: Text(
                    errorMessage == "" ? '' : "*$errorMessage",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InputTextField(
                  label: "الاسم",
                  controller: _nameController,
                  icon: Icon(Icons.person_outline),
                ),
                DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    // style: const TextStyle(color: ),
                    iconSize: 15,
                    underline: Container(
                      height: 2,
                      color: kSecondaryColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['ذكر', 'أنثى']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
                // if (_isLoading)
                //   CircularProgressIndicator()
                // else
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: deviceSize.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            child: Text(
                              'دخول',
                              style: GoogleFonts.elMessiri(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                                primary: kSecondaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
