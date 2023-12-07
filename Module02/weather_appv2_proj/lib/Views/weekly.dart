import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';

import '../TopBottomBars/city_model.dart';
import '../utils/wmo_weather_codes.dart';
import 'WeatherLogic/weather_getter.dart';

class WeeklyView extends StatefulWidget {
  const WeeklyView({required this.localisation, required this.data, super.key});

  final CityModel? localisation;
  final WeatherModel? data;

  @override
  State<WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  @override
  Widget build(BuildContext context) {
    if (widget.localisation != null) {
      return Column(
        children: [
          Text(widget.localisation!.name),
          Text('${widget.localisation!.country}, ${widget.localisation!.region}\n'),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: widget.data!.weekly.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.date),
                      Text('${item.minTemp} °C'),
                      Text('${item.maxTemp} °C'),
                      Text(WmoWeatherCodes.getSkyFromCode(item.weatherDescription)),
                    ],
                  ),
              )).toList(),
              ),
          ),
        ],
      );
    }
    return const Center(child: Text('No Localisation\n'));
  }
}
