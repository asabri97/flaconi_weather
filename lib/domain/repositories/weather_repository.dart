import 'package:dartz/dartz.dart';
import 'package:flaconi_weather/core/errors/failures.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Forecast>> getForecast(String city);
}
