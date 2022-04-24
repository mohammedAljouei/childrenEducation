import 'package:educatechildren/constants.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    required this.label,
    required this.controller,
    required this.icon,
    this.password = false,
  });

  final String label;
  final controller;
  final bool password;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: onChange,
      obscureText: password,
      controller: controller,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        suffixIcon: icon,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIconColor: kSecondaryColor,
        iconColor: kSecondaryColor,
        border: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: kSecondaryColor,
          width: 2,
        )),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: kSecondaryColor,
          width: 2,
        )),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
          width: 0.5,
        )),
      ),
    );
  }
}
