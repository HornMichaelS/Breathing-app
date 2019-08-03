import 'package:flutter/material.dart';
import 'dart:async';

typedef void NextCallback({Duration delay});
typedef Widget SequenceItemBuilder(NextCallback next);

class AnimatedSwitcherSequenceController with ChangeNotifier {
  void skipToNext() {
    notifyListeners();
  }
}

class AnimatedSwitcherSequence extends StatefulWidget {
  AnimatedSwitcherSequence({@required this.builders, this.controller, this.beforeLoop}) {
    if (builders.length < 2) {
      throw FlutterError('AnimatedWidgetSequence must be passed at least 2 builder functions in the builders property.');
    }
  }

  /// A list of builder functions, which are used to build the widgets in the sequence.
  /// There must be at least 2 builder functions.
  final List<SequenceItemBuilder> builders;

  /// An optional controller which can be used to skip immediately to the next widget in the sequence.
  final AnimatedSwitcherSequenceController controller;

  /// This callback will be run before the sequence loops around to the first widget again.
  final Function beforeLoop;

  @override
  _AnimatedSwitcherSequenceState createState() => _AnimatedSwitcherSequenceState();
}

class _AnimatedSwitcherSequenceState extends State<AnimatedSwitcherSequence> {
  int currentWidget = 0;

  Timer delayTimer;

  AnimatedSwitcherSequenceController controller;

  void _advanceWidget() {
    if (currentWidget == widget.builders.length - 1) {
      widget.beforeLoop?.call();
    }

    setState(() {
      currentWidget = (currentWidget + 1) % widget.builders.length;
    });
  }

  void next({Duration delay}) {
    if (delay == null) {
      delayTimer?.cancel();
      delayTimer = null;
      _advanceWidget();
      return;
    }

    if (delayTimer != null) {
      delayTimer.cancel();
    }

    delayTimer = Timer(delay, _advanceWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = widget.controller;
    controller?.addListener(next);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.builders);
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: widget.builders[currentWidget](next),
    );
  }

  @override
  void dispose() {
    delayTimer?.cancel();
    controller?.removeListener(next);
    super.dispose();
  }
}
