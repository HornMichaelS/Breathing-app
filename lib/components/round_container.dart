import 'package:flutter/material.dart';

class RoundContainer extends StatelessWidget {
  const RoundContainer({
    @required double radius,
    this.child,
    this.color = Colors.white,
  }) : _circleRadius = radius;

  final double _circleRadius;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: _circleRadius * 2,
          maxWidth: _circleRadius * 2,
          minHeight: _circleRadius * 2,
          minWidth: _circleRadius * 2,
        ),
        child: child,
      ),
      borderRadius: (() {
        return BorderRadius.circular(_circleRadius * 2);
      })(),
      elevation: 5,
    );
  }
}
