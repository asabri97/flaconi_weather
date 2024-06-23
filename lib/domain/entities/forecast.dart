import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/domain/entities/weather.dart';

class Forecast extends Equatable {
  final List<Weather> daily;

  const Forecast({required this.daily});

  @override
  List<Object> get props => [daily];
}
