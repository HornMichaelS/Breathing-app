import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';

class TimeSliderCard extends StatelessWidget {
  const TimeSliderCard({
    @required this.value,
    @required this.onChanged,
    @required this.title,
    this.min = 30,
    this.max = 300,
  });

  final int value;
  final double min;
  final double max;
  final ChangeCallback onChanged;
  final String title;

  String get durationString => '${Duration(seconds: value).inMinutes}:${Duration(seconds: value).inSeconds.remainder(60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: kCardTitleTextStyle,
            ),
            Text(
              durationString,
              style: TextStyle(
                fontSize: 45,
              ),
            ),
            Slider(
              value: value.toDouble(),
              onChanged: onChanged,
              min: min,
              max: max,
              divisions: ((max - min) / 5).floor(),
            )
          ],
        ),
      ),
    );
  }
}
