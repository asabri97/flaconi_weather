import 'package:flutter/material.dart';
import 'weather_detail_card.dart';

class WeatherAdditionalInfo extends StatelessWidget {
  final num humidity;
  final num pressure;
  final num windSpeed;

  const WeatherAdditionalInfo({
    super.key,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherDetailCard(
          title: 'Humidity',
          value: '$humidity%',
        ),
        WeatherDetailCard(
          title: 'Pressure',
          value: '$pressure hPa',
        ),
        WeatherDetailCard(
          title: 'Wind',
          value: '$windSpeed km/h',
        ),
      ],
    );
  }
}
