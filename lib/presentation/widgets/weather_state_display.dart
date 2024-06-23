import 'package:flaconi_weather/presentation/blocs/weather_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flaconi_weather/presentation/blocs/weather_bloc.dart';
import 'package:flaconi_weather/presentation/blocs/weather_state.dart';
import 'package:flaconi_weather/presentation/screens/weather_detail_screen.dart';

class WeatherStateDisplay extends StatelessWidget {
  final String city;

  const WeatherStateDisplay({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherError) {}
        if (state is WeatherLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WeatherDetailScreen(forecast: state.forecast, city: city),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is WeatherInitial) {
          return const Center(child: Text('Enter a city to get the weather.'));
        } else if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (city.isNotEmpty) {
                      context.read<WeatherBloc>().add(FetchWeather(city));
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
