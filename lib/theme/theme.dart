import 'dart:ui';
import 'package:flutter/material.dart';

class MyTheme {

  static const red = Color(0XFFE81935);
  static const pink = Color(0XFFD7385E);
  static const blue = Color(0XFF132743);
  static const gray = Color(0XFFEBEBEB);
  static const black = Color(0XFF222831);
  static const yellow = Color(0XFFFFA62B);
  static const yellowlight = Color(0XFFF8EFD4);

  static final themeData = ThemeData(
    textSelectionTheme: TextSelectionThemeData(cursorColor: pink, selectionHandleColor: pink, selectionColor: pink),
    primaryColor: blue,
    accentColor: black,
    textTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 17.0, fontFamily: 'BalooThambi2Regular'), // textformfields
      subtitle2: TextStyle(fontSize: 17.0, fontFamily: 'BalooThambi2Bold'),
      bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'BalooThambi2SemiBold', color: Colors.white), // buttons
      bodyText2: TextStyle(fontSize: 17.0, fontFamily: 'BalooThambi2Regular'),
      headline6: TextStyle(fontSize: 17.0, fontFamily: 'BalooThambi2Regular'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: pink,
      helperStyle: TextStyle(fontFamily: 'BalooThambi2Regular'),
      hintStyle: TextStyle(fontSize: 17.0, fontFamily: 'BalooThambi2Regular'),
      errorStyle: TextStyle(fontFamily: 'BalooThambi2Medium', color: red, fontSize: 14.0),
    )
  );

}