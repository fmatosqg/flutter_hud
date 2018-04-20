import 'package:flutter/material.dart';

//get theme => themeMediumWidth;
ThemeData getTheme(MediaQueryData mediaQueryData) {
  print("Media Query says screen width is ${mediaQueryData.size.width}");

  final width = mediaQueryData.size.width;
  if (width >= 800.0) {
    return themeBigWidth;
  } else if (width >= 500) {
    return themeMediumWidth;
  } else {
    return themeSmallWidth;
  }
}

ThemeData get theThemeForTheWholeApp => new ThemeData();

// phone
var themeSmallWidth = new ThemeData(
  primarySwatch: Colors.deepPurple,
  backgroundColor: Colors.deepPurpleAccent,
  canvasColor: Colors.black38,
  textTheme: defaultTextStyle,
);

// phone landscape
var themeMediumWidth = themeSmallWidth.copyWith(
  textTheme: themeSmallWidth.textTheme.copyWith(
    title: new TextStyle(fontSize: 70.0),
    subhead: new TextStyle(fontSize: 20.0),
  ),
);

// rpi preview 4 (width 800)
var themeBigWidth = themeSmallWidth.copyWith(
  textTheme: themeSmallWidth.textTheme.copyWith(
    title: new TextStyle(fontSize: 100.0),
    subhead: new TextStyle(fontSize: 40.0),
  ),
);

TextTheme get defaultTextStyle => new TextTheme(
      title: new TextStyle(fontSize: 40.0),
      display4: new TextStyle(fontSize: 10.0),
      display3: new TextStyle(fontSize: 10.0),
      display2: new TextStyle(fontSize: 10.0),
      display1: new TextStyle(fontSize: 10.0),
      headline: new TextStyle(fontSize: 10.0),
      subhead: new TextStyle(fontSize: 10.0),
      body2: new TextStyle(fontSize: 10.0),
      body1: new TextStyle(fontSize: 30.0),
      caption: new TextStyle(fontSize: 10.0),
      button: new TextStyle(fontSize: 10.0),
    );
