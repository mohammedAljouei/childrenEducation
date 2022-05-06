// ignore_for_file: unused_field
//ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:educatechildren/main.dart';
import 'package:educatechildren/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Widgets/input_text_field.dart';
import '../constants.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  // static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    AuthMode _authMode = AuthMode.Login;

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
  AuthMode _authMode = AuthMode.Login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _emailController = TextEditingController();
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

    var url =
        "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${id}.json";
    final res = await http.put(Uri.parse(url),
        body: json.encode({
          "user": {
            "gender": gender,
            "name": _nameController.text,
            "id": id,
            "doneLet": "",
            "doneNum": ""
          }
        }));
    final body = await json.decode(res.body);
    print(body);
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in

      const url =
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBf5kaROMc7c8Lf0QwChzL4CrkILXTvB5k";

      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
            'returnSecureToken': true
          }));
      final body = json.decode(res.body);
      final id = body['localId'];
      print(id); // null in case wrong
      if (id == null) {
        errorMessage = 'البريد الالكتروني المدخل او كلمة المرور غير صحيحة';
      }
      if (id != null) {
        await _storage.write(
          key: 'token',
          value: id,
        );

        var url =
            "https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/${id}/user.json";
        final res = await http.get(Uri.parse(url));
        final body = json.decode(res.body);
        var doneNum = body['doneNum'];
        var doneLet = body['doneLet'];
        var name = body['name'];
        var gender = body['gender'];

        await _storage.write(
          key: 'name',
          value: name,
        );

        await _storage.write(
          key: 'gender',
          value: gender.toString(),
        );

        await _storage.write(
          key: 'doneLet',
          value: doneLet,
        );
        await _storage.write(
          key: 'doneNum',
          value: doneNum,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      }
    } else {
      const url =
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBf5kaROMc7c8Lf0QwChzL4CrkILXTvB5k";
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
            'returnSecureToken': true
          }));

      final body = json.decode(res.body);
      final id = body['localId'];
      if (_passwordController.text != _password2Controller) {
        errorMessage = 'كلمة المرور غير متطابقة';
      }
      if (id == null) {
        errorMessage = '';
        if (body['error']['message'] == 'INVALID_EMAIL') {
          errorMessage = 'ادخل بريد الكتروني صالح';
        } else {
          errorMessage = 'كلمة المرور يجب أن تحتوي على ستة خانات على الاقل';
        }
      }
      if (id != null) {
        await _storage.write(
          key: 'token',
          value: id,
        );

        await saveUser(id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      }
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(children: [
        Text(
          _authMode == AuthMode.Login ? 'تسجيل دخول' : 'تسجيل جديد',
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
                  label: "بريدك الالكتروني",
                  controller: _emailController,
                  icon: Icon(Icons.email_outlined),
                ),
                if (_authMode == AuthMode.Signup)
                  InputTextField(
                    label: "الاسم",
                    controller: _nameController,
                    icon: Icon(Icons.person_outline),
                  ),
                InputTextField(
                    label: "كلمة المرور",
                    controller: _passwordController,
                    icon: Icon(Icons.lock_outlined),
                    password: true),
                if (_authMode == AuthMode.Signup)
                  InputTextField(
                      label: "تأكيد كلمة المرور",
                      controller: _password2Controller,
                      icon: Icon(Icons.lock_outlined),
                      password: true),
                if (_authMode == AuthMode.Signup)
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
                              _authMode == AuthMode.Login
                                  ? 'تسجل دخول'
                                  : 'تسجيل جديد',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _authMode == AuthMode.Login
                                ? "ليس لديك حساب؟ "
                                : "لديك حساب مسبقا؟ ",
                            style: GoogleFonts.elMessiri(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _switchAuthMode,
                            child: Text(
                              _authMode == AuthMode.Login
                                  ? "تسجيل جديد"
                                  : "تسجيل دخول",
                              style: GoogleFonts.elMessiri(
                                  fontSize: 15,
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
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
