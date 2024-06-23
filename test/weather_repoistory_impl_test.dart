import 'package:flaconi_weather/core/errors/exceptions.dart';
import 'package:flaconi_weather/core/errors/failures.dart';
import 'package:flaconi_weather/data/models/forecast_model.dart';
import 'package:flaconi_weather/data/models/weather_model.dart';
import 'package:flaconi_weather/data/repositories/weather_repository_impl.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl.mocks.dart';

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
    repository = WeatherRepositoryImpl(mockWeatherService);
  });

  const tCity = 'Berlin';
  const tWeatherModel = WeatherModel(
    day: '2024-06-23T12:00:00.000Z',
    condition: 'Clear',
    icon: '01d',
    temperature: 25.0,
    humidity: 60,
    pressure: 1012,
    windSpeed: 5.0,
  );

  const tForecastModel = ForecastModel(daily: [tWeatherModel]);

  const tForecast = Forecast(daily: [
    Weather(
      day: '2024-06-23T12:00:00.000Z',
      condition: 'Clear',
      icon: '01d',
      temperature: 25.0,
      humidity: 60,
      pressure: 1012,
      windSpeed: 5.0,
    )
  ]);

  test('should return forecast when the call to weather service is successful',
      () async {
    // arrange
    when(mockWeatherService.fetchWeather(any))
        .thenAnswer((_) async => tForecastModel);

    // act
    final result = await repository.getForecast(tCity);

    // assert
    result.fold(
      (failure) => fail('Expected Right but got Left'),
      (forecast) {
        expect(forecast, tForecast);
      },
    );
    verify(mockWeatherService.fetchWeather(tCity));
    verifyNoMoreInteractions(mockWeatherService);
  });

  test(
      'should return server failure when the call to weather service is unsuccessful',
      () async {
    // arrange
    when(mockWeatherService.fetchWeather(any)).thenThrow(ServerException());

    // act
    final result = await repository.getForecast(tCity);

    // assert
    result.fold(
      (failure) {
        expect(failure, isA<ServerFailure>());
      },
      (forecast) => fail('Expected Left but got Right'),
    );
    verify(mockWeatherService.fetchWeather(tCity));
    verifyNoMoreInteractions(mockWeatherService);
  });
}
