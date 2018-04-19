import 'package:flutter/material.dart';

//get theme => themeMediumWidth;
ThemeData getTheme(MediaQueryData mediaQueryData) {
  print("Media Query says screen width is ${mediaQueryData.size.width}");

  if (mediaQueryData.size.width >= 800.0) {
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
    textTheme: new TextTheme(title: new TextStyle(fontSize: 40.0)));

// rpi preview 4 (width 800)
var themeMediumWidth = themeSmallWidth.copyWith(
  textTheme: themeSmallWidth.textTheme.copyWith(
    title: new TextStyle(fontSize: 100.0),
    subhead: new TextStyle(fontSize: 40.0),
  ),
);
