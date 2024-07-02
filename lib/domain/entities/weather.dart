import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String day;
  final String condition;
  final String icon;
  final num temperature;
  final num humidity;
  final num pressure;
  final num windSpeed;

  const Weather({
    required this.day,
    required this.condition,
    required this.icon,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        day,
        condition,
        icon,
        temperature,
        humidity,
        pressure,
        windSpeed,
      ];

  @override
  String toString() {
    return 'Weather(day: $day, condition: $condition, icon: $icon, temperature: $temperature, humidity: $humidity, pressure: $pressure, windSpeed: $windSpeed)';
  }
}
