import 'package:flutter/material.dart';

final primaryColor = Color(0xff00cec9);
final accentColor = Color(0xff0984e3);

final ThemeData theme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    accentColor: accentColor,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          elevation: 1,
          color: Colors.white,
        ),
    primaryTextTheme: ThemeData.light()
        .primaryTextTheme
        .apply(bodyColor: primaryColor, displayColor: primaryColor),
    primaryIconTheme:
        ThemeData.light().primaryIconTheme.copyWith(color: primaryColor),
    floatingActionButtonTheme: ThemeData.light()
        .floatingActionButtonTheme
        .copyWith(backgroundColor: primaryColor));
