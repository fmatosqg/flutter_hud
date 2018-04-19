import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_hud/Themes.dart';
import 'package:flutter_hud/ui/face/clock/clock.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';
import 'dart:ui' as ui;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var objectFactory = ObjectFactory.instance;

    var scaffold = Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: new ClockFace(
          objectFactory.getWifiManager(), objectFactory.getBluetoothManager()),
    );

    return new MaterialApp(
      theme: getTheme(new MediaQueryData.fromWindow(ui.window)),
      home: scaffold,
    );
  }
}
