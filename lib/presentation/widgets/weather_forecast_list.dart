import 'package:flutter/material.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';
import 'package:intl/intl.dart';

class WeatherForecastList extends StatelessWidget {
  final List<Weather> forecast;
  final Function(Weather) onWeatherTap;

  const WeatherForecastList(
      {super.key, required this.forecast, required this.onWeatherTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final weather = forecast[index];
          return GestureDetector(
            onTap: () => onWeatherTap(weather),
            child: Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(DateTime.parse(weather.day)),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Image.network(
                    'http://openweathermap.org/img/w/${weather.icon}.png',
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
