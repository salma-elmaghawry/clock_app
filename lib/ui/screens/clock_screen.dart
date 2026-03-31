import 'package:clock_app/core/app_colors.dart';
import 'package:clock_app/core/const.dart';
import 'package:clock_app/ui/widgets/build_clock.dart';
import 'package:clock_app/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  DateTime _dateTime = DateTime.now();
  ClockType _clockType = ClockType.analog;
  double _clockSize = 250.0;
  Color _clockColor = AppColors.primaryBlue;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Update time every second using Timer.periodic
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Octal Clock'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        clockType: _clockType,
        onClockTypeChanged: (type) {
          setState(() {
            _clockType = type;
          });
        },
        clockSize: _clockSize,
        onClockSizeChanged: (size) {
          setState(() {
            _clockSize = size;
          });
        },
        clockColor: _clockColor,
        availableColors: AppColors.clockColors,
        onClockColorChanged: (color) {
          setState(() {
            _clockColor = color;
          });
        },
      ),

      //<===== Body ========>
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 140),
            //  display
            Text(
              '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.clockGrey,
              ),
            ),
            const SizedBox(height: 40),
            // Dynamic Clock display
            buildClock(_clockType, _dateTime, _clockSize, _clockColor),
          ],
        ),
      ),
    );
  }
}
