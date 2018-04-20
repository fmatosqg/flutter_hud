import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_hud/Themes.dart';
import 'package:flutter_hud/ui/face/clock/clock.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';
import 'dart:ui' as ui;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();

  @override
  StatefulElement createElement() {
    print('hello');
    return super.createElement();
  }
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ThemeData _theme;

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
      theme: _theme,
      home: scaffold,
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateTheme();
  }

  @override
  reassemble() {
    super.reassemble();
    updateTheme();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycle $state');
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _theme = getTheme(_mediaQueryData);
    });
  }

  /////////////////////////////
  MediaQueryData get _mediaQueryData =>
      new MediaQueryData.fromWindow(ui.window);

  Timer updateTheme() {
    _timer?.cancel();

    setState(() {
      _theme = getTheme(_mediaQueryData);
    });
    _timer = new Timer(new Duration(seconds: 10), () {
      print('Update theme');
      setState(() {
        _theme = getTheme(_mediaQueryData, isNightTheme: true);
      });
    });
  }

  Timer _timer;
}
