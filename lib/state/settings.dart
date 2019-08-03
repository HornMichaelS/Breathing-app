import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  int _numRounds = 3;
  int _breathsPerRound = 35;
  int _holdTime = 120;
  int _speed = 6;

  int get numRounds => _numRounds;
  int get breathsPerRound => _breathsPerRound;
  int get holdTime => _holdTime;
  int get speed {
    return _speed;
  }

  set numRounds(int newValue) {
    _numRounds = newValue;
    notifyListeners();
  }

  set breathsPerRound(int newValue) {
    _breathsPerRound = newValue;
    notifyListeners();
  }

  set holdTime(int newValue) {
    _holdTime = newValue;
    notifyListeners();
  }

  set speed(int newValue) {
    _speed = newValue;
    notifyListeners();
  }
}
