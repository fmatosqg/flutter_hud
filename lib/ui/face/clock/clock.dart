import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/bridge/network/IpAddress.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ClockFace extends StatefulWidget {
  final WifiManager _wifiManager;

  ClockFace(this._wifiManager);

  @override
  State<StatefulWidget> createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  String _ip;
  String _date;
  String _time;

  StreamSubscription _tick;

  StreamSubscription<ConnectivityResult> _subscription;

  Timer _periodicTimer;

  ClockFaceState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(_ip),
              new Text(_date),
              new Text(
                _time,
                style:
                    Theme.of(context).textTheme.title.copyWith(fontSize: 40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _ip = "init";
    _time = "now";
    _date = 'today';
    loadIp();
    startTick();
  }

  @override
  void reassemble() {
    super.reassemble();
    loadIp();

    startTick();
  }

  @override
  void dispose() {
    _tick.cancel();
    _tick = null;
    _periodicTimer.cancel();
    _periodicTimer = null;
    super.dispose();
  }

  void loadIp() async {
    _subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      IpAddress().getIp().then((ip) {
        setState(() {
          _ip = '$result $ip ss';
        });
      });
    });
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

    _tick = Observable.periodic(new Duration(seconds: 1)).listen((c) {
      updateTime();
    });
  }

  void updateTime() {
    var now = new DateTime.now();

    var timeFormatted = new DateFormat('HH:mm:ss').format(now);
    var dateFormatted = new DateFormat("EEEE, dd/MMM/yyyy").format(now);

    setState(() {
      print('hello');
      _time = timeFormatted;
      _date = dateFormatted;
    });
  }
}
