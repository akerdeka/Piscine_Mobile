import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';

import '../utils/wmo_weather_codes.dart';
import 'WeatherLogic/weather_getter.dart';

class TodayView extends StatefulWidget {
  const TodayView({required this.localisation, required this.data, super.key});

  final CityModel? localisation;
  final WeatherModel? data;

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
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
              children: widget.data!.daily.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.time.substring(11, item.time.length)),
                    Text('${item.temperature} °C'),
                    Text(WmoWeatherCodes.getSkyFromCode(item.weatherDescription)),
                    Text('${item.windSpeed} km/h'),
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
