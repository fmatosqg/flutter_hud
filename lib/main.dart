import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hud/Themes.dart';
import 'package:flutter_hud/ui/face/clock/clock.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';

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
    final ObjectFactory objectFactory = ObjectFactory.instance;

    final Widget scaffold = new Scaffold(
      body: new ClockFace(
          objectFactory.getWifiManager(), objectFactory.getBluetoothManager()),
    );

    return new MaterialApp(
      builder: (BuildContext context, Widget child) {
        return new Theme(
          data: getTheme(MediaQuery.of(context), isNightTheme: _isNightTheme),
          child: child,
        );
      },
      home: scaffold,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateTheme();
  }

  @override
  void reassemble() {
    super.reassemble();
    updateTheme();
  }

  @override
  void dispose() {
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
