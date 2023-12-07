import 'package:flutter/cupertino.dart';

class HourlyModel {

  String time = "";
  String temperature = ""; // Celsius
  int weatherDescription = -1; // cloudy, sunny, rainy, etc.
  String windSpeed = ""; // km/h

  HourlyModel(this.time, this.temperature, this.weatherDescription, this.windSpeed);

  HourlyModel.fromJson(Map<String, dynamic>json) {
    time = json["time"].toString();
    temperature = json["temperature_2m"].toString();
    weatherDescription = int.parse(json["weather_code"].toString());
    windSpeed = json["wind_speed_10m"].toString();
  }

  HourlyModel.fromJsonToHours(Map<String, dynamic>json, int index) {
    time = json["time"][index].toString();
    temperature = json["temperature_2m"][index].toString();
    weatherDescription = int.parse(json["weather_code"][index].toString());
    windSpeed = json["wind_speed_10m"][index].toString();
  }
}

class DailyModel {

  String date = "";
  String minTemp = "";
  String maxTemp = "";
  int weatherDescription = -1;

  DailyModel(this.date, this.minTemp, this.maxTemp, this.weatherDescription);

  DailyModel.fromJson(Map<String, dynamic>json, int index) {
    date = json["time"][index].toString();
    minTemp = json["temperature_2m_min"][index].toString();
    maxTemp = json["temperature_2m_max"][index].toString();
    weatherDescription = int.parse(json["weather_code"][index].toString());
  }
}

class WeatherModel {

  late HourlyModel current;
  late List<HourlyModel> daily;
  late List<DailyModel> weekly;

  WeatherModel(this.current, this.daily, this.weekly);

  factory WeatherModel.fromJson(Map<String, dynamic>json) {

    List<HourlyModel> daily = List<HourlyModel>.empty(growable: true);
    for (int index = 0; index < 24; index++) {
      daily.add(HourlyModel.fromJsonToHours(json["hourly"], index));
    }

    List<DailyModel> weekly = List<DailyModel>.empty(growable: true);
    for (int index = 0; index < 7; index++) {
      weekly.add(DailyModel.fromJson(json["daily"], index));
    }

    final WeatherModel weather = WeatherModel(
        HourlyModel.fromJson(json["current"]),
        daily,
        weekly);

    return weather;
  }
}