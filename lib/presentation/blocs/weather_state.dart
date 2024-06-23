import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';

/// Abstract class representing a state of the weather data.
abstract class WeatherState extends Equatable {
  /// Creates a [WeatherState] instance.
  const WeatherState();

  @override
  List<Object> get props => [];
}

/// State representing the initial state before any weather data is fetched.
class WeatherInitial extends WeatherState {}

/// State representing the loading state while fetching weather data.
class WeatherLoading extends WeatherState {}

/// State representing the loaded state with fetched weather data.
class WeatherLoaded extends WeatherState {
  /// The fetched forecast data.
  final Forecast forecast;

  /// The currently selected weather data.
  final Weather selectedWeather;

  /// Creates a [WeatherLoaded] state with the provided forecast and selected weather data.
  const WeatherLoaded(this.forecast, this.selectedWeather);

  @override
  List<Object> get props => [forecast, selectedWeather];
}

/// State representing an error state with an error message.
class WeatherError extends WeatherState {
  /// The error message describing the issue.
  final String message;

  /// Creates a [WeatherError] state with the provided error message.
  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
