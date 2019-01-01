import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/bridge/network/IpAddress.dart';
import 'package:flutter_hud/domain/album/ServerAlbumRepo.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ClockFace extends StatefulWidget {
  final AlbumRepo _albumRepo;

  ClockFace(this._albumRepo);

  factory ClockFace.forDesignTime() {
    return new ClockFace(null);
  }

  @override
  State<StatefulWidget> createState() => new ClockFaceState();
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
    _periodicTimer?.cancel();
    _periodicTimer = null;
    super.dispose();
  }

  void loadIp() async {
    _subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      IpAddress().getIp().then((String ip) {
        setState(() {
          _ip = '$result $ip';
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
}
