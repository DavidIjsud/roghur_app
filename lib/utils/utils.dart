import 'package:flutter/material.dart';

bool isNumber(value) {
  if (value == null) return false;
  if (int.tryParse(value) != null && int.parse(value) > 0) {
    return true;
  } else
    return false;
}

bool isEmail(String texto) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(texto)) {
    return true;
  } else {
    return false;
  }
}

void showMessage(GlobalKey<ScaffoldState> key, String message) {
  key.currentState.showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}
