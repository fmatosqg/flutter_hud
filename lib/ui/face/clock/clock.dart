import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockFace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClockFaceState();
}

class ClockFaceState extends State<ClockFace> {
  ClockFaceState();

  DateTime time;

  Timer timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _updateTime(),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  void _updateTime() {
    setState(() {
      time = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amber.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: DigitalClock(time),
        ),
      ),
    );
  }
}

class DigitalClock extends StatelessWidget {
  final DateTime time;

  DigitalClock(this.time);
  DateFormat timeFormat = DateFormat('HH:mm a');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd EEEE');

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
