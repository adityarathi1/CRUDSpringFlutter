import 'package:flutter/material.dart';

const TextStyle inputTextStyle = TextStyle(
  letterSpacing: 1,
  fontSize: 18,
);
const Color logoColor = Color(0xFF00ADEF);
Widget getRoundedTextField({
  TextInputType inputType,
  String labelText,
  String errorText,
  int maxLength,
  bool obscureText: false,
  bool autoFocus: false,
  double contentPadding: 16,
  TextEditingController controller,
  Function onEditComplete,
  Function onChange,
  Function onTap,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: inputType,
    maxLength: maxLength,
    autocorrect: false,
    onEditingComplete: onEditComplete,
    onChanged: onChange,
    autofocus: autoFocus,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: logoColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      hintStyle: inputTextStyle,
      labelText: labelText,
      labelStyle: inputTextStyle,
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(contentPadding),
    ),
    enableSuggestions: false,
    textAlign: TextAlign.left,
    onTap: onTap,
  );
}
