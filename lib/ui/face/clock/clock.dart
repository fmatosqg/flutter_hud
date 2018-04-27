import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hud/domain/wifi/BluetoothManager.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ClockFace extends StatefulWidget {
  final WifiManager _wifiManager;
  final BluetoothManager _bluetoothManager;

  ClockFace(this._wifiManager, this._bluetoothManager);

  @override
  State<StatefulWidget> createState() => new ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  String _ip;
  String _date;
  String _time;

  String _bluetoothStatus;

  StreamSubscription _tick;

  Timer _periodicTimer;

  Timer _btTimer;

  ClockFaceState();

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;

    Widget _newText(String text, TextTheme style) =>
        new Text(text, style: style.body1);

    return new Container(
      child: new Center(
        child: new Card(
          child: new Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(12.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _newText(_ip, textStyle),
                _newText(_date, textStyle),
                new Text(
                  _time,
                  style: textStyle.title,
                ),
                _newText(_bluetoothStatus, textStyle),
//                new MyIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _ip = 'init';
    _time = 'now';
    _date = 'today';
    _bluetoothStatus = 'BT - init';
    loadIp();
    startTick();
    doBluetoothThing();
  }

  @override
  void reassemble() {
    super.reassemble();

    _bluetoothStatus = 'BT - reassemble';
    loadIp();

    startTick();
    doBluetoothThing();
  }

  @override
  void dispose() {
    _tick.cancel();
    _tick = null;
    _periodicTimer?.cancel();
    _periodicTimer = null;
    _btTimer?.cancel();
    _btTimer = null;
    super.dispose();
  }

  void loadIp() async {
//    _subscription = new Connectivity()
//        .onConnectivityChanged
//        .listen((ConnectivityResult result) {
//      IpAddress().getIp().then((String ip) {
//        setState(() {
//          _ip = '$result $ip';
//          _bluetoothStatus = 'BT: ' + widget._bluetoothManager.status();
//        });
//      });
//    });
  }

  void startTick() {
    startTickWithTimer();
  }

  void startTickWithTimer() {
    if (_periodicTimer != null) {
      _periodicTimer.cancel();
    }

    _periodicTimer =
        new Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }

  void startTickWithRx() {
    if (_tick != null) {
      _tick.cancel();
    }

    _tick = Observable.periodic<int>(const Duration(seconds: 1)).listen((int c) {
      updateTime();
    });
  }

  void updateTime() {
    final DateTime now = new DateTime.now();

    final String timeFormatted = new DateFormat('HH:mm:ss').format(now);
    final String  dateFormatted = new DateFormat('EEEE, dd MMMM yyyy').format(now);

    setState(() {
//      print('hello');
      _time = timeFormatted;
      _date = dateFormatted;
      _bluetoothStatus = 'BT: ' + widget._bluetoothManager.status();
    });
  }

  void doBluetoothThing() {
    _bluetoothStatus = 'BT about to start advertising';
    widget._bluetoothManager.startAdvertising();

    _btTimer?.cancel();

    widget._bluetoothManager.scan();

    _btTimer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        _bluetoothStatus =
            'BT 5 seconds later ${widget._bluetoothManager.status()}';
      });
    });
  }
}
