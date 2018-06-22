import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/bridge/network/IpAddress.dart';
import 'package:flutter_hud/domain/album/ServerAlbumRepo.dart';
import 'package:flutter_hud/domain/wifi/BluetoothManager.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';
import 'package:flutter_hud/ui/face/clock/MyIconAnimation.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ClockFace extends StatefulWidget {
  final WifiManager _wifiManager;
  final BluetoothManager _bluetoothManager;
  final AlbumRepo _albumRepo;

  ClockFace(this._wifiManager, this._bluetoothManager, this._albumRepo);

  factory ClockFace.forDesignTime() {
    return new ClockFace(null, null, null);
  }

  @override
  State<StatefulWidget> createState() => new ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  String _ip;
  String _date;
  String _time;

  String _bluetoothStatus;

  StreamSubscription _tick;

  StreamSubscription<ConnectivityResult> _subscription;

  Timer _periodicTimer;

  Timer _btTimer;

  ClockFaceState();

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    var url = widget._albumRepo.getAlbumList().first.thumbnail;
    Widget _newText(String text, TextTheme style) =>
        new Text(text, style: style.body1);

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Image(
            image: NetworkImage(url),
          ),
        ),
        Container(
          child: Center(
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _newText(_ip, textStyle),
                    _newText(_date, textStyle),
                    new Text(
                      _time,
                      style: textStyle.title,
                    ),
                    _newText(_bluetoothStatus, textStyle),

                    Text(url),

//                new MyIcon(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
    _subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      IpAddress().getIp().then((String ip) {
        setState(() {
          _ip = '$result $ip';
          _bluetoothStatus = 'BT: ' + widget._bluetoothManager.status();
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

    _tick = Observable.periodic(const Duration(seconds: 1)).listen((c) {
      updateTime();
    });
  }

  void updateTime() {
    final DateTime now = new DateTime.now();

    final String timeFormatted = new DateFormat('HH:mm').format(now);
    var dateFormatted = new DateFormat("EEEE, dd MMMM yyyy").format(now);

    setState(() {
      print('hello');
      _time = timeFormatted;
      _date = dateFormatted;
    });
  }

  void doBluetoothThing() {
    _bluetoothStatus = 'BT about to start advertising';
    widget._bluetoothManager.startAdvertising();

    _btTimer?.cancel();
    _btTimer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        _bluetoothStatus =
            'BT 5 seconds later ${widget._bluetoothManager.status()}';
      });
    });
  }
}
