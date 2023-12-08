import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';

class WeatherGetter {

  static Future<WeatherModel> getWeatherByCityModel(CityModel localisation) async {
    try {
      http.Response res = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast'
              '?latitude=${localisation.latitude}&longitude=${localisation.longitude}'
              '&current=temperature_2m,weather_code,wind_speed_10m'
              '&hourly=temperature_2m,weather_code,wind_speed_10m'
              '&daily=weather_code,temperature_2m_max,temperature_2m_min'
              '&forecast_days=7'));

      WeatherModel weather = WeatherModel.fromJson(jsonDecode(res.body));
      return weather;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<WeatherModel> getWeatherByPosition(Position position) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
            '?latitude=${position.latitude}&longitude=${position.longitude}'
            '&current=temperature_2m,weather_code,wind_speed_10m'
            '&hourly=temperature_2m,weather_code,wind_speed_10m'
            '&daily=weather_code,temperature_2m_max,temperature_2m_min'
            '&forecast_days=7'));

    debugPrint(res.body);
    WeatherModel weather = WeatherModel.fromJson(jsonDecode(res.body));
    return weather;
  }
}