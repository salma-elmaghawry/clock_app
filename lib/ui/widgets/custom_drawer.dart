import 'package:clock_app/core/const.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final ClockType clockType;
  final Function(ClockType) onClockTypeChanged;
  final double clockSize;
  final Function(double) onClockSizeChanged;
  final Color clockColor;
  final List<Color> availableColors;
  final Function(Color) onClockColorChanged;

  const CustomDrawer({
    super.key,
    required this.clockType,
    required this.onClockTypeChanged,
    required this.clockSize,
    required this.onClockSizeChanged,
    required this.clockColor,
    required this.availableColors,
    required this.onClockColorChanged,
  });

  // Build clock type options
  List<Widget> _buildClockTypeOptions() {
    final typeNames = {
      ClockType.analog: 'Analog Clock',
      ClockType.digital: 'Digital Clock',
      ClockType.text: 'Text Clock',
    };

    List<Widget> options = [];
    for (var type in ClockType.values) {
      options.add(
        RadioListTile<ClockType>(
          value: type,
          groupValue: clockType,
          onChanged: (value) {
            if (value != null) {
              onClockTypeChanged(value);
            }
          },
          title: Text(typeNames[type]!),
          contentPadding: EdgeInsets.zero,
        ),
      );
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                //<=============== Clock type options =================>
                ..._buildClockTypeOptions(),
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
                //<=============== Clock size options =================>
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
                  value: clockSize,
                  min: 100,
                  max: 400,
                  onChanged: (value) {
                    onClockSizeChanged(value);
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //<=============== Clock color options =================>
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
                  children: availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        onClockColorChanged(color);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: clockColor == color
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
    );
  }
}
