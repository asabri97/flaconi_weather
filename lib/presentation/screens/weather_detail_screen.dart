import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flaconi_weather/domain/entities/forecast.dart';
import 'package:flaconi_weather/presentation/blocs/weather_bloc.dart';
import 'package:flaconi_weather/presentation/blocs/weather_event.dart';
import 'package:flaconi_weather/presentation/blocs/weather_state.dart';
import 'package:flaconi_weather/presentation/widgets/weather_condition.dart';
import 'package:flaconi_weather/presentation/widgets/weather_temperature.dart';
import 'package:flaconi_weather/presentation/widgets/weather_additional_info.dart';
import 'package:flaconi_weather/presentation/widgets/weather_forecast_list.dart';
import 'package:intl/intl.dart';

class WeatherDetailScreen extends StatefulWidget {
  final Forecast forecast;
  final String city;

  const WeatherDetailScreen(
      {super.key, required this.forecast, required this.city});

  @override
  WeatherDetailScreenState createState() => WeatherDetailScreenState();
}

class WeatherDetailScreenState extends State<WeatherDetailScreen> {
  bool isCelsius = true;

  Future<void> _refresh(BuildContext context) async {
    if (kDebugMode) {
      debugPrint('Refreshing weather data...');
    }
    context.read<WeatherBloc>().add(FetchWeather(widget.city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return Text(DateFormat('EEEE')
                  .format(DateTime.parse(state.selectedWeather.day)));
            }
            return const Text('');
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoaded) {
                      final weather = state.selectedWeather;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WeatherCondition(
                            condition: weather.condition,
                            iconUrl:
                                'http://openweathermap.org/img/w/${weather.icon}.png',
                          ),
                          const SizedBox(height: 16),
                          WeatherTemperature(
                            temperature: weather.temperature,
                            isCelsius: isCelsius,
                            onToggle: (value) {
                              setState(() {
                                isCelsius = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          WeatherAdditionalInfo(
                            humidity: weather.humidity,
                            pressure: weather.pressure,
                            windSpeed: weather.windSpeed,
                          ),
                          const SizedBox(height: 32),
                          WeatherForecastList(
                            forecast: widget.forecast.daily.sublist(1),
                            onWeatherTap: (weather) {
                              context
                                  .read<WeatherBloc>()
                                  .add(UpdateSelectedWeather(weather));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherDetailScreen(
                                    forecast: widget.forecast,
                                    city: widget.city,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => _refresh(context),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
