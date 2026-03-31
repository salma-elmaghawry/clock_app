import 'package:clock_app/core/const.dart';
import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

Widget buildClock(
  ClockType clockType,
  DateTime dateTime,
  double clockSize,
  Color clockColor,
) {
  switch (clockType) {
    case ClockType.analog:
      return AnalogClock(
        isLive: true,
        width: clockSize,
        height: clockSize,
        datetime: dateTime,
        decoration: BoxDecoration(
          color: clockColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
      );
    case ClockType.digital:
      return DigitalClock(
        isLive: true,
        datetime: dateTime,
        textScaleFactor: clockSize / 200,
        showSeconds: true,
      );
    case ClockType.text:
      return Text(
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}',
        style: TextStyle(
          fontSize: clockSize / 2,
          fontWeight: FontWeight.bold,
          color: clockColor,
        ),
      );
  }
}
