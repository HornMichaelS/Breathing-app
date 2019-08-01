import 'package:flutter/material.dart';
import 'package:focus/components/time_slider_card.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/components/number_selection_card.dart';
import 'package:focus/screens/breathe_screen.dart';
import 'package:provider/provider.dart';
import 'package:focus/state/settings.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'SettingsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'SETTINGS',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NumberSelectionCard(
                value: Provider.of<Settings>(context).numRounds,
                title: 'Rounds',
                onChanged: (newValue) {
                  Provider.of<Settings>(context).numRounds = newValue;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              NumberSelectionCard(
                value: Provider.of<Settings>(context).breathsPerRound,
                title: 'Breaths',
                onChanged: (newValue) {
                  Provider.of<Settings>(context).breathsPerRound = newValue;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Consumer<Settings>(
                builder: (context, settings, child) => TimeSliderCard(
                  value: settings.holdTime,
                  onChanged: (newValue) {
                    if (newValue.ceil() != settings.holdTime) {
                      settings.holdTime = newValue.ceil();
                    }
                  },
                  title: 'Hold Time',
                  min: 5,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.lightBlueAccent,
                height: 50.0,
                onPressed: () {
                  Navigator.pushNamed(context, BreatheScreen.id);
                },
                child: Text(
                  'GO',
                  style: kTitleTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
