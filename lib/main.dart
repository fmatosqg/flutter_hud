import 'package:flutter/material.dart';
import 'package:flutter_hud/ui/face/clock/clock.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: new ClockFace(ObjectFactory.instance.getWifiManager()));

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: theme1,
      home: scaffold,
    );
  }
}

var theme1 = new ThemeData(
  primarySwatch: Colors.blue,
  backgroundColor: Colors.black38,
  canvasColor: Colors.black38,
);
