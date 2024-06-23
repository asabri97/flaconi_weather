import 'package:flutter/material.dart';

class WeatherTemperature extends StatelessWidget {
  final double temperature;
  final bool isCelsius;
  final ValueChanged<bool> onToggle;

  const WeatherTemperature({
    super.key,
    required this.temperature,
    required this.isCelsius,
    required this.onToggle,
  });

  String _formatTemperature(double celsius) {
    if (isCelsius) {
      return '${celsius.toStringAsFixed(1)}°C';
    } else {
      double fahrenheit = (celsius * 9 / 5) + 32;
      return '${fahrenheit.toStringAsFixed(1)}°F';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formatTemperature(temperature),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isCelsius ? 'Get temp in Fahrenheit' : 'Get temp in Celsius',
              style: const TextStyle(fontSize: 18),
            ),
            Switch(
              value: isCelsius,
              onChanged: onToggle,
              activeTrackColor: Colors.lightBlueAccent,
              activeColor: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
