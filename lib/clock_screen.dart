import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

enum ClockType { analog, digital, text }

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  DateTime _dateTime = DateTime.now();
  ClockType _clockType = ClockType.analog;
  double _clockSize = 250.0;
  Color _clockColor = Colors.blue;

  final List<Color> _availableColors = [
    Colors.grey[700]!,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
  ];

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

  Widget _buildClock() {
    switch (_clockType) {
      case ClockType.analog:
        return AnalogClock(
          isLive: true,
          width: _clockSize,
          height: _clockSize,
          datetime: _dateTime,
          decoration: BoxDecoration(
            color: _clockColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        );
      case ClockType.digital:
        return DigitalClock(
          isLive: true,
          datetime: _dateTime,
          textScaleFactor: _clockSize / 200,
          showSeconds: true,
          format: 'Hms',
        );
      case ClockType.text:
        return Text(
          '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}:${_dateTime.second.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: _clockSize / 2,
            fontWeight: FontWeight.bold,
            color: _clockColor,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Octal Clock'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.white, size: 32),
                  const SizedBox(width: 16),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Clock Type Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Text(
                        'Clock Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...ClockType.values.map((type) {
                    final typeNames = {
                      ClockType.analog: 'Analog Clock',
                      ClockType.digital: 'Digital Clock',
                      ClockType.text: 'Text Clock',
                    };
                    return RadioListTile<ClockType>(
                      value: type,
                      groupValue: _clockType,
                      onChanged: (value) {
                        setState(() {
                          _clockType = value!;
                        });
                      },
                      title: Text(typeNames[type]!),
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ],
              ),
            ),
            const Divider(),
            // Clock Size Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.text_fields, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Text(
                        'Clock Size',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _clockSize,
                    min: 100,
                    max: 400,
                    divisions: 30,
                    onChanged: (value) {
                      setState(() {
                        _clockSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            // Clock Color Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.palette, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Text(
                        'Clock Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availableColors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _clockColor = color;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: _clockColor == color
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Date display
              Text(
                '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              // Dynamic Clock display
              _buildClock(),
            ],
          ),
        ),
      ),
    );
  }
}
