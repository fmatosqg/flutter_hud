import 'package:flutter/material.dart';


ThemeData getTheme(MediaQueryData mediaQueryData, {bool isNightTheme: false}) {
  print("Media Query says screen width is ${mediaQueryData.size.width}");

  final width = mediaQueryData.size.width;

  var baseTheme = isNightTheme ? nightTheme : dayTheme;
  final textColor = isNightTheme ? Colors.white : Colors.black;

  return baseTheme.copyWith(
    textTheme: buildDefaultTextTheme(width / 30.0, textColor: textColor),
  );
}

final ThemeData nightTheme = new ThemeData(
  primarySwatch: Colors.deepPurple,
);
final ThemeData dayTheme = new ThemeData(
  primarySwatch: Colors.lightBlue,
);

TextTheme buildDefaultTextTheme(double bodyFontSize,
    {Color textColor: Colors.yellow}) {
  final baseTextStyle = new TextStyle(fontSize: bodyFontSize, color: textColor);

  new TextTheme(
    title: baseTextStyle.copyWith(fontSize: bodyFontSize * 4),
    display4: baseTextStyle,
    display3: baseTextStyle,
    display2: baseTextStyle,
    display1: baseTextStyle,
    headline: baseTextStyle,
    subhead: baseTextStyle,
    body2: baseTextStyle,
    body1: baseTextStyle,
    caption: baseTextStyle,
    button: baseTextStyle,
  );
}
