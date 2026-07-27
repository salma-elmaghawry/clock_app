import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomHeader({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(icon, color: Colors.grey),
        const SizedBox(width: 12),
         Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
