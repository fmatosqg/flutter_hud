import 'package:flutter/material.dart';
import 'package:flutter_hud/util/di/ObjectFactory.dart';

class ClockFace extends StatefulWidget {
  final WifiManager _wifiManager;

  ClockFace(this._wifiManager);

  @override
  State<StatefulWidget> createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
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
              new Text(widget._wifiManager.ip),
            ],
          ),
        ),
      ),
    );
  }
}
