import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_hud/Themes.dart';
import 'package:flutter_hud/ui/face/clock/clock.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';
import 'dart:ui' as ui;

import 'package:flutter_hud/utils/ServiceLocator.dart';

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
  Timer _timer;

  bool _isNightTheme;

  @override
  Widget build(BuildContext context) {
    var serviceLocator = ServiceLocator.instance;

    var scaffold = new Scaffold(
      body: new ClockFace(
        serviceLocator.getWifiManager(),
        serviceLocator.getAlbumRepo(),
      ),
    );

    return new MaterialApp(
      builder: (context, child) {
        _mediaQueryData = MediaQuery.of(context);
        var _theme = getTheme(_mediaQueryData, isNightTheme: _isNightTheme);
        return new Theme(
          data: _theme,
          child: child,
        );
      },
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
    updateTheme();
  }

  /////////////////////////////
//  MediaQueryData get _mediaQueryData =>
//      new MediaQueryData.fromWindow(ui.window);

  MediaQueryData _mediaQueryData = new MediaQueryData(size: new Size(0.0, 0.0));

  void updateTheme() {
    _timer?.cancel();
    _isNightTheme = false;

    _timer = new Timer(new Duration(seconds: 10), () {
      print('Update theme');
      setState(() {
        _isNightTheme = true;
      });
    });
  }
}
