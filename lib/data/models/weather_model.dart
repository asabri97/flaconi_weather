import 'package:flaconi_weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.day,
    required super.condition,
    required super.icon,
    required super.temperature,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      day: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)
          .toIso8601String(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'],
    );
  }
}
