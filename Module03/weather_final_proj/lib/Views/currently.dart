import 'package:flutter/material.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
      return FittedBox(
        alignment: Alignment.topCenter,
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: [
                    Text(widget.localisation!.name, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    Text('${widget.localisation!.country}, ${widget.localisation!.region}', style: const TextStyle( fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('${widget.data!.current.temperature} °C', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ),
              Column(
                children: [
                  Text(WmoWeatherCodes.getSkyFromCode(widget.data!.current.weatherDescription), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(WmoWeatherCodes.getIconFromCode(widget.data!.current.weatherDescription), color: Colors.amber, size: 70,)
                ],
              ),
              Row(
                children: [
                  const Icon(FluentIcons.weather_blowing_snow_48_filled),
                  Text('${widget.data!.current.windSpeed} km/h', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(child: Text('No Localisation\n'));
    }
  }
}
