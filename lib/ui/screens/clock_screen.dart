import 'package:clock_app/clock_screen.dart';
import 'package:clock_app/core/app_colors.dart';
import 'package:clock_app/ui/widgets/build_clock.dart';
import 'package:clock_app/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    // Update time every second
    Future.delayed(Duration.zero, () {
      _updateTime();
    });
  }

  void _updateTime() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
        _updateTime();
      }
    });
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date display
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
