import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focus/components/round_container.dart';
import 'package:focus/utilities/breathing_animation.dart';
import 'package:focus/state/settings.dart';

class BreathingCircleController extends ValueNotifier<bool> {
  BreathingCircleController({bool animationShouldRun}) : super(animationShouldRun ?? false);

  void stopAnimation() {
    this.value = false;
  }

  void startAnimation() {
    this.value = true;
  }
}

class BreathingCircle extends StatefulWidget {
  BreathingCircle({
    this.didCompleteCycle,
    this.child,
    BreathingCircleController controller,
  }) : _controller = controller;

  final Function didCompleteCycle;
  final Widget child;
  final BreathingCircleController _controller;

  @override
  _BreathingCircleState createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle> with SingleTickerProviderStateMixin {
  static const double _baseRadius = 80;

  double circleRadius = _baseRadius;

  BreathingAnimation breathingAnimation;

  BreathingCircleController controller;
  Function listener;

  Settings settings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = widget._controller ?? BreathingCircleController();

    listener = () {
      if (controller.value) {
        breathingAnimation.start();
      } else {
        breathingAnimation.stop();
      }
    };

    controller.addListener(listener);
  }

  @override
  void didChangeDependencies() {
    print(controller);
    super.didChangeDependencies();

    settings = Provider.of<Settings>(context);

    if (breathingAnimation == null) {
      breathingAnimation = BreathingAnimation(
        vsync: this,
        initialSpeed: settings.speed,
        min: _baseRadius,
        max: _baseRadius * 1.5,
        didCompleteOutBreath: widget.didCompleteCycle,
      );

      breathingAnimation.addListener(() {
        setState(() {
          circleRadius = breathingAnimation.value;
        });
      });

      controller.startAnimation();
    } else {
      breathingAnimation.updateSpeed(settings.speed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundContainer(
      radius: circleRadius,
      color: Colors.lightBlueAccent[200],
      child: Center(
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    breathingAnimation.dispose();
    controller?.stopAnimation();
    controller?.removeListener(listener);
    super.dispose();
  }
}
