import 'dart:math';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalogClock extends StatelessWidget {
  final DateTime time;

  AnalogClock(this.time);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: AnalogClockBackgroundPainter(),
          child: Container(
            width: 500,
            height: 500,
            color: Colors.black12,
          ),
        ),
        CustomPaint(
          painter: AnalogClockHandsPainter(time),
          child: Container(
            width: 500,
            height: 500,
            color: Colors.black12,
          ),
        )
      ],
    );
  }
}

/// Draws the static clock face - ticks and numbers
///
class AnalogClockBackgroundPainter extends CustomPainter {
  Paint _paintBackground = Paint()..color = Colors.black26;
  Paint _paintTicks = Paint()..color = Colors.black;
  Paint _paintTicksStrong = Paint()
    ..color = Colors.black
    ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, size.height / 2, _paintBackground);

    for (double teta = 0; teta < 2 * pi; teta += 2 * pi / 60) {
      _drawTick(teta, canvas, size, center, false);
    }

    for (double teta = 0; teta < 2 * pi; teta += 2 * pi / 12) {
      _drawTick(teta, canvas, size, center, true);
    }

    for (int hour = 1; hour <= 12; hour++) {
      _drawHours(canvas, size, center, hour);
    }
  }

  void _drawTick(
      double teta, Canvas canvas, Size size, Offset center, bool isStrong) {
    Offset start = Offset(
          cos(teta) * size.height,
          sin(teta) * size.height,
        ) *
        0.5;
    var end = start * (isStrong ? 0.8 : 0.9);

    canvas.drawLine(start + center, end + center,
        isStrong ? _paintTicksStrong : _paintTicks);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  _drawHours(Canvas canvas, Size size, Offset center, int hour) {
    double teta = (hour) * 2 * pi / 12.0 - pi / 2;
    Offset start = Offset(
              cos(teta) * size.height,
              sin(teta) * size.height,
            ) *
            0.33 +
        center;

    TextSpan span = TextSpan(
        style: TextStyle(
          color: Colors.yellow,
          fontSize: size.height / 10,
        ),
        text: "$hour");
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );

    tp.layout();
    start = start + Offset(-tp.width / 2, -tp.height / 2);

    tp.paint(canvas, start);
  }
}

class AnalogClockHandsPainter extends CustomPainter {
  final DateTime time;
  AnalogClockHandsPainter(this.time);

  static var _handColor = Colors.yellowAccent[100];

  Paint _paintHour = Paint()
    ..color = _handColor
    ..strokeWidth = 15;

  Paint _paintMinute = Paint()
    ..color = _handColor
    ..strokeWidth = 5;

  Paint _paintSeconds = Paint()
    ..color = _handColor
    ..isAntiAlias = true
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final tetaHour = time.hour * (2 * pi / 12);
    final tetaMinute = time.minute * (2 * pi / 60);
    final tetaSeconds = (time.second + time.millisecond / 1000) * (2 * pi / 60);

    final center = Offset(size.width, size.height) / 2;

    _drawHand(canvas, center, _paintHour, tetaHour, 0.5);
    _drawHand(canvas, center, _paintMinute, tetaMinute, 0.9);
    _drawHand(canvas, center, _paintSeconds, tetaSeconds, 0.98);
  }

  void _drawHand(Canvas canvas, Offset center, Paint paint, double teta,
      double handLenght) {
    teta = teta - pi / 2;
    final end = Offset(cos(teta), sin(teta)) * center.dy * handLenght + center;

    canvas.drawLine(center, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
