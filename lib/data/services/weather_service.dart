import 'dart:convert';
import 'package:flaconi_weather/core/errors/exceptions.dart';
import 'package:flaconi_weather/core/network/network_info.dart';
import 'package:flaconi_weather/data/models/forecast_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final NetworkInfo networkInfo;

  WeatherService({required this.networkInfo});

  Future<ForecastModel> fetchWeather(String city) async {
    if (!await networkInfo.isConnected) {
      throw ServerException();
    }

    final coordinates = await getCoordinates(city);
    final lat = coordinates['lat'];
    final lon = coordinates['lon'];

    return fetchForecast(lat!, lon!);
  }

  Future<Map<String, double>> getCoordinates(String city) async {
    final baseUrl = dotenv.env['BASE_URL'];
    final apiKey = dotenv.env['API_KEY'];

    final url = '$baseUrl/geo/1.0/direct?q=$city&limit=1&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {
          'lat': data[0]['lat'],
          'lon': data[0]['lon'],
        };
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  Future<ForecastModel> fetchForecast(double lat, double lon) async {
    final baseUrl = dotenv.env['BASE_URL'];
    final apiKey = dotenv.env['API_KEY'];

    final url =
        '$baseUrl/data/2.5/forecast?lat=$lat&lon=$lon&cnt=40&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
