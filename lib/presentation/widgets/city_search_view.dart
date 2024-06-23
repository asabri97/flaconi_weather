import 'package:flaconi_weather/presentation/widgets/weather_state_display.dart';
import 'package:flutter/material.dart';
import 'package:flaconi_weather/presentation/widgets/city_search_input.dart';

class CitySearchView extends StatefulWidget {
  const CitySearchView({super.key});

  @override
  CitySearchViewState createState() => CitySearchViewState();
}

class CitySearchViewState extends State<CitySearchView> {
  String _city = '';

  void _setCity(String city) {
    setState(() {
      _city = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CitySearchInput(onSearch: _setCity),
        const SizedBox(height: 20),
        if (_city.isNotEmpty)
          Expanded(
            child: WeatherStateDisplay(city: _city),
          ),
      ],
    );
  }
}
