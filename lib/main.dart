import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flaconi_weather/data/repositories/weather_repository_impl.dart';
import 'package:flaconi_weather/data/services/weather_service.dart';
import 'package:flaconi_weather/domain/usecases/get_forecast.dart';
import 'package:flaconi_weather/presentation/blocs/weather_bloc.dart';
import 'package:flaconi_weather/presentation/screens/city_search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading .env file: $e');
    print('BASE_URL: ${dotenv.env['BASE_URL']}');
    print('API_KEY: ${dotenv.env['API_KEY']}');
  }

  final weatherService = WeatherService(
    networkInfo: NetworkInfoImpl(Connectivity()),
  );
  final weatherRepository = WeatherRepositoryImpl(weatherService);
  final getForecast = GetForecast(weatherRepository);

  runApp(WeatherApp(getForecast: getForecast));
}

class WeatherApp extends StatelessWidget {
  final GetForecast getForecast;

  const WeatherApp({super.key, required this.getForecast});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(getForecast: getForecast),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CitySearchScreen(),
      ),
    );
  }
}
