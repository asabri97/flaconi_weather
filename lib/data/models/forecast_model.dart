import 'package:flaconi_weather/data/models/weather_model.dart';

class ForecastModel {
  final List<WeatherModel> daily;

  const ForecastModel({required this.daily});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;

    Map<String, WeatherModel> dailyMap = {};

    for (var item in list) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final date = dateTime.toIso8601String().split('T').first;

      if (dailyMap.containsKey(date)) {
        final existingModel = dailyMap[date]!;
        final existingTime = DateTime.parse(existingModel.day).hour;
        if ((dateTime.hour - 12).abs() < (existingTime - 12).abs()) {
          dailyMap[date] = WeatherModel.fromJson(item);
        }
      } else {
        dailyMap[date] = WeatherModel.fromJson(item);
      }
    }

    List<WeatherModel> dailyList = dailyMap.values.toList();
    return ForecastModel(daily: dailyList);
  }
}
