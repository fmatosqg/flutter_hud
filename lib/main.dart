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
  MediaQueryData _mediaQueryData = new MediaQueryData.fromWindow(ui.window);

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
    _theme = getTheme(_mediaQueryData);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  reassemble() {
    super.reassemble();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycle $state');
//    setState(() { _notification = state; });
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _mediaQueryData = new MediaQueryData.fromWindow(ui.window);
      _theme = getTheme(_mediaQueryData);
    });
  }

  void handleMetricsChanged() {
    print('metrics changed');
  }
}
