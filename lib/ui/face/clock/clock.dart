import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'analog_clock.dart';

class ClockFace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  ClockFaceState();

  DateTime time;

  Timer _timer;

  Timer _burninTimer; // add random paddings to avoid display burn in
  EdgeInsetsGeometry paddings;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _updatePadding();

    _timer = Timer.periodic(
      // const Duration(seconds: 1),
      const Duration(milliseconds: 1000),
      (Timer t) => _updateTime(),
    );

    _burninTimer = Timer.periodic(
      const Duration(minutes: 1),
      (Timer t) => _updatePadding(),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _timer.cancel();
    _burninTimer.cancel();
  }

  void _updateTime() {
    setState(() {
      time = DateTime.now().toLocal();
    });
  }

  void _updatePadding() {
    var r = Random();

    const maxPadding = 50;

    paddings = EdgeInsets.fromLTRB(
      r.nextDouble() * maxPadding,
      r.nextDouble() * maxPadding,
      r.nextDouble() * maxPadding,
      r.nextDouble() * maxPadding,
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    _updatePadding();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.brown,
        child: Padding(
          padding: paddings,
          // child: DigitalClock(time),
          child: AnalogClock(time),
        ),
      ),
    );
  }
}

class DigitalClock extends StatelessWidget {
  static DateFormat timeFormat12H = DateFormat('hh:mm a');
  static DateFormat timeFormat24H = DateFormat('HH:mm:ss');

  static DateFormat timeFormat = timeFormat24H;
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd EEEE');

  final DateTime time;
  DigitalClock(this.time);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dateFormat.format(time),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          timeFormat.format(time),
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}

class ClockTimeDto {
  final int time;

  ClockTimeDto(this.time);
}
