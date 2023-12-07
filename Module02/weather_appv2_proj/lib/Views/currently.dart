import 'package:flutter/material.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';
import 'WeatherLogic/weather_getter.dart';
import '../TopBottomBars/city_model.dart';
import '../utils/wmo_weather_codes.dart';

class CurrentlyView extends StatefulWidget {
  const CurrentlyView({required this.localisation, required this.data, super.key});

  final CityModel? localisation;
  final WeatherModel? data;

  @override
  State<CurrentlyView> createState() => _CurrentlyViewState();
}

class _CurrentlyViewState extends State<CurrentlyView> {

  @override
  Widget build(BuildContext context) {
    if (widget.localisation != null) {
      return Column(
        children: [
          Text(widget.localisation!.name),
          Text('${widget.localisation!.country}, ${widget.localisation!.region}\n'),
          Text('${widget.data!.current.temperature} °C'),
          Text(WmoWeatherCodes.getSkyFromCode(widget.data!.current.weatherDescription)),
          Text('${widget.data!.current.windSpeed} km/h'),
        ],
      );
    } else {
      return const Center(child: Text('No Localisation\n'));
    }
  }
}
