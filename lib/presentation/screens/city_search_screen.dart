import 'package:flaconi_weather/presentation/widgets/city_search_view.dart';
import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CitySearchView(),
      ),
    );
  }
}
