import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';

/// Abstract class representing a weather-related event.
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch weather data for a specified city.
class FetchWeather extends WeatherEvent {
  final String city;
  const FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

/// Event to update the selected weather.
class UpdateSelectedWeather extends WeatherEvent {
  final Weather selectedWeather;
  const UpdateSelectedWeather(this.selectedWeather);

  @override
  List<Object> get props => [selectedWeather];
}
