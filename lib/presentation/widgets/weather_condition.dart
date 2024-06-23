import 'package:flutter/material.dart';

class WeatherCondition extends StatelessWidget {
  final String condition;
  final String iconUrl;

  const WeatherCondition(
      {super.key, required this.condition, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          condition,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Image.network(
          iconUrl,
          scale: 0.4,
        ),
      ],
    );
  }
}
