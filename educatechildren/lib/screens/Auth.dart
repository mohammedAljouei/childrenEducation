// ignore_for_file: unused_field
//ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        body: Directionality(
      textDirection: TextDirection.rtl, // عربي
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/backgroud_letters.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
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
  // late final ValueChanged<String> onChanged =  () => ('a'){};
  String errorMessage = '';
  final _storage = FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  // _AuthCardState({
  //   this.icon = Icons.person,
  //   this.onChanged,
  // });

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  saveUser(String id) async {
    var gender = 0;
    if (dropdownValue == 'أنثى') {
      gender = 1;
    }

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
    final body = json.decode(res.body);
    print(body);
  }

  void _submit() async {
    setState(() {});
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
        // final email = _emailController.text;
        // final url = 'https://mutamimon.com/381/forget.php?email=$email';
        // await http.get(Uri.parse(url));
        await _storage.write(
          key: 'token',
          value: id,
        );
        Navigator.pushNamed(context, '/home');
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
        saveUser(id);
        Navigator.pushNamed(context, '/home');
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
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment(0, -0.85),
        child: Text(
          _authMode == AuthMode.Login ? 'تسجيل دخول' : 'تسجيل جديد',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment(0, 0.25),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  errorMessage == null ? '' : "*$errorMessage",
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  // onChanged: onChanged,
                  // cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      icon,
                      // color: kPrimaryColor,
                    ),
                    hintText: "بريدك الالكتروني",
                    border: InputBorder.none,
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextField(
                    enabled: _authMode == AuthMode.Signup,
                    controller: _nameController,
                    // onChanged: onChanged,
                    // cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        icon,
                        // color: kPrimaryColor,
                      ),
                      hintText: "الاسم",
                      border: InputBorder.none,
                    ),
                  ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  // onChanged: onChanged,
                  // cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "كلمة المرور",
                    icon: Icon(
                      Icons.lock,
                      // color: kPrimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      // color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                          }
                        : null,
                    // cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "تأكيد كلمة المرور",
                      icon: Icon(
                        Icons.lock,
                        // color: kPrimaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        // color: kPrimaryColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                if (_authMode == AuthMode.Signup)
                  DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
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
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
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
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
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
                              style: const TextStyle(
                                  // color: kPrimaryColor
                                  ),
                            ),
                            GestureDetector(
                              onTap: _switchAuthMode,
                              child: Text(
                                _authMode == AuthMode.Login
                                    ? "تسجيل جديد"
                                    : "تسجيل دخول",
                                style: const TextStyle(
                                  // color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
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
        ),
      )
    ]);
  }
}
