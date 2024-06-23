import 'package:dartz/dartz.dart';
import 'package:flaconi_weather/core/errors/failures.dart';
import 'package:flaconi_weather/core/usecases/usecase.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';
import 'package:flaconi_weather/domain/repositories/weather_repository.dart';

class GetForecast implements UseCase<Forecast, Params> {
  final WeatherRepository repository;

  GetForecast(this.repository);

  @override
  Future<Either<Failure, Forecast>> call(Params params) async {
    return await repository.getForecast(params.city);
  }
}

class Params {
  final String city;

  Params({required this.city});
}
