import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flaconi_weather/core/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flaconi_weather/data/repositories/weather_repository_impl.dart';
import 'package:flaconi_weather/data/services/weather_service.dart';
import 'package:flaconi_weather/domain/usecases/get_forecast.dart';
import 'package:flaconi_weather/presentation/blocs/weather_bloc.dart';
import 'package:flaconi_weather/presentation/screens/city_search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    assert(() {
      debugPrint('Env file loaded successfully');
      return true;
    }());
  } catch (e) {
    assert(() {
      debugPrint('Error loading .env file: $e');
      return true;
    }());
    debugPrint('Error loading .env file: $e');
  }

  final baseUrl = dotenv.env['BASE_URL'];
  final apiKey = dotenv.env['API_KEY'];

  if (baseUrl == null || apiKey == null) {
    assert(() {
      debugPrint('BASE_URL or API_KEY is not set in the .env file');
      return true;
    }());
    debugPrint('BASE_URL or API_KEY is not set in the .env file');
    return;
  }

  final weatherService = WeatherService(
    networkInfo: NetworkInfoImpl(Connectivity()),
    baseUrl: baseUrl,
    apiKey: apiKey,
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
