import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/bridge/network/IpAddress.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ClockFace extends StatefulWidget {
  final WifiManager _wifiManager;

  ClockFace(this._wifiManager);

  @override
  State<StatefulWidget> createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  String _ip;

  StreamSubscription<ConnectivityResult> _subscription;

  ClockFaceState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(_ip),
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
    loadIp();
  }

  @override
  void reassemble() {
    super.reassemble();
    loadIp();
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
}
