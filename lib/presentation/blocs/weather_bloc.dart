import 'package:bloc/bloc.dart';
import 'package:flaconi_weather/domain/usecases/get_forecast.dart';
import 'package:flaconi_weather/presentation/blocs/weather_event.dart';
import 'package:flaconi_weather/presentation/blocs/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetForecast getForecast;

  WeatherBloc({required this.getForecast}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<UpdateSelectedWeather>(_onUpdateSelectedWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final failureOrForecast = await getForecast(Params(city: event.city));
    failureOrForecast.fold(
      (failure) => emit(const WeatherError(
          "Could not fetch weather. Is the device online? Is the city name correct?")),
      (forecast) {
        final selectedWeather = forecast.daily.first;
        emit(WeatherLoaded(forecast, selectedWeather));
      },
    );
  }

  void _onUpdateSelectedWeather(
      UpdateSelectedWeather event, Emitter<WeatherState> emit) {
    if (state is WeatherLoaded) {
      final loadedState = state as WeatherLoaded;
      emit(WeatherLoaded(loadedState.forecast, event.selectedWeather));
    }
  }
}
