import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class MyIcon extends StatefulWidget {
  MyIcon() {}

  factory MyIcon.forDesignTime() => new MyIcon();

  createState() => new MyIconState();
}

class MyIconState extends State<MyIcon> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text('dsdsdsdd'),
        _buildAnimatedIcon(),
      ],
    );
  }

  Widget _buildAnimatedIcon() {

    return new Column(
      children: <Widget>[
        new AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.arrow_menu,
        ),
        new AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.menu_arrow,
        ),
        new AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.play_pause,
        ),
        new AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.pause_play,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 4),
    );

    new Timer(new Duration(seconds: 5), () {
      print("Start animation");
      _animationController.forward();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    _animationController.forward(from: 0.0);
  }
}
