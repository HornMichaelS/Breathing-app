import 'package:flutter/material.dart';
import 'dart:math';

class BreathingAnimation {
  BreathingAnimation({
    int initialSpeed = 2,
    @required TickerProvider vsync,
    double min = 0,
    double max = 1,
    Function didCompleteInBreath,
    Function didCompleteOutBreath,
  }) {
    _speed = initialSpeed;

    _animationController = AnimationController(vsync: vsync);

    var curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutSine);

    _animationController.duration = getDuration(fromSpeed: _speed);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();

        if (didCompleteInBreath != null) {
          didCompleteInBreath();
        }
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();

        if (didCompleteOutBreath != null) {
          didCompleteOutBreath();
        }
      }
    });

    _tweenedAnimation = Tween<double>(begin: min, end: max).animate(curvedAnimation);
  }

  int _speed;
  Animation _tweenedAnimation;
  AnimationController _animationController;

  Duration getDuration({@required int fromSpeed}) {
    return Duration(milliseconds: (10000 / pow(1.35, fromSpeed)).floor());
  }

  double get value => _tweenedAnimation.value;

  void start() {
    _animationController.forward();
  }

  void stop() {
    _animationController.stop();
  }

  void addListener(Function listener) {
    _animationController.addListener(listener);
  }

  void updateSpeed(int newSpeed) {
    if (newSpeed == _speed) {
      return;
    }

    _speed = newSpeed;

    double start = _animationController.value;

    _animationController.duration = getDuration(fromSpeed: newSpeed);

    if (_animationController.status == AnimationStatus.forward) {
      _animationController.forward(from: start);
    } else if (_animationController.status == AnimationStatus.reverse) {
      _animationController.reverse(from: start);
    }
  }

  void dispose() {
    print('Disposing ticker');
    _animationController.dispose();
  }
}
