import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flaconi_weather/presentation/blocs/weather_bloc.dart';
import 'package:flaconi_weather/presentation/blocs/weather_event.dart';

class CitySearchInput extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const CitySearchInput({super.key, required this.onSearch});

  @override
  CitySearchInputState createState() => CitySearchInputState();
}

class CitySearchInputState extends State<CitySearchInput> {
  final TextEditingController _controller = TextEditingController();

  void _searchWeather() {
    if (_controller.text.isNotEmpty) {
      widget.onSearch(_controller.text);
      context.read<WeatherBloc>().add(FetchWeather(_controller.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Enter City',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) => _searchWeather(),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _searchWeather,
          child: const Text('Get Weather'),
        ),
      ],
    );
  }
}
