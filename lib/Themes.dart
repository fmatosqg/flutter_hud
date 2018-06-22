import 'package:flutter/material.dart';

ThemeData getTheme(MediaQueryData mediaQueryData, {bool isNightTheme: false}) {
  print("Media Query says screen width is ${mediaQueryData.size.width}");

  final width = mediaQueryData.size.width;

  var baseTheme = isNightTheme ? nightTheme : dayTheme;
  final textColor = isNightTheme ? Colors.white70 : Colors.black87;

  var textTheme = buildDefaultTextTheme(width / 30.0, textColor: textColor);

  if (width > 799) {
    // rpi3
    return superDark.copyWith(textTheme: textTheme);
  }

  return baseTheme.copyWith(
    textTheme: textTheme,
  );
}

final ThemeData nightTheme = new ThemeData(
  primarySwatch: Colors.deepPurple,
  backgroundColor: Colors.deepPurple,
  canvasColor: Colors.deepPurple,
  cardColor: const Color(0x22ddddff),
  iconTheme: new IconThemeData(
    color: Colors.lightBlue,
  ),
);

final ThemeData superDark = new ThemeData(
  primarySwatch: Colors.blueGrey,
  canvasColor: Colors.blueGrey[700],
  cardColor: Colors.blueGrey[500],
);

final ThemeData dayTheme = new ThemeData(
  primarySwatch: Colors.lightBlue,
  canvasColor: Colors.lightBlue,
  cardColor: const Color(0x22ddddff),
  backgroundColor: Colors.lightBlueAccent,
  iconTheme: new IconThemeData(color: Colors.black54),
);

TextTheme buildDefaultTextTheme(double bodyFontSize,
    {Color textColor: Colors.black}) {
  final baseTextStyle = new TextStyle(fontSize: bodyFontSize, color: textColor);

  return new TextTheme(
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

class AppColors {
//  static const Color darkPurple = Color(0xFFFDF7F6);
//  static const Color darkPurpleAccent = Color(0x44FDF7F6);
}
