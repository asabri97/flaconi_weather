import 'package:dartz/dartz.dart';
import 'package:flaconi_weather/core/errors/exceptions.dart';
import 'package:flaconi_weather/core/errors/failures.dart';
import 'package:flaconi_weather/data/services/weather_service.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';
import 'package:flaconi_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService service;

  WeatherRepositoryImpl(this.service);

  @override
  Future<Either<Failure, Forecast>> getForecast(String city) async {
    try {
      final forecastModel = await service.fetchWeather(city);
      List<Weather> dailyForecast = forecastModel.daily
          .map((weatherModel) => Weather(
                day: weatherModel.day,
                condition: weatherModel.condition,
                icon: weatherModel.icon,
                temperature: weatherModel.temperature,
                humidity: weatherModel.humidity,
                pressure: weatherModel.pressure,
                windSpeed: weatherModel.windSpeed,
              ))
          .toList();
      final forecast = Forecast(daily: dailyForecast);
      return Right(forecast);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
