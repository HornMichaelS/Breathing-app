import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.child, this.onPressed, this.color, this.height = 55.0});

  final Widget child;
  final Color color;
  final Function onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.all(0),
      minWidth: 55,
      child: MaterialButton(
        elevation: 1,
        color: color,
        onPressed: onPressed,
        child: child,
        shape: CircleBorder(),
        height: height,
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
