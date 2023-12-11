import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class WmoWeatherCodes {

  static Map<int, Map<String, IconData>> wmoCodes = {
    0: {"Clear sky": FluentIcons.weather_sunny_48_regular},
    1: {"Mainly clear": FluentIcons.weather_sunny_48_regular},
    2: {"Partly cloudy": FluentIcons.weather_partly_cloudy_day_48_regular},
    3: {"Overcast": FluentIcons.weather_cloudy_48_regular},
    45: {"Fog": FluentIcons.weather_fog_48_regular},
    48: {"Depositing rime fog": FluentIcons.weather_fog_48_regular},
    51: {"Light Drizzle": FluentIcons.weather_drizzle_48_regular},
    53: {"Moderate Drizzle": FluentIcons.weather_drizzle_48_regular},
    55: {"Dense Drizzle": FluentIcons.weather_drizzle_48_regular},
    56: {"Light Freezing Drizzle": FluentIcons.weather_drizzle_48_regular},
    57: {"Dense Freezing Drizzle": FluentIcons.weather_drizzle_48_regular},
    61: {"Slight rain": FluentIcons.weather_rain_48_regular},
    63: {"Moderate rain": FluentIcons.weather_rain_48_regular},
    65: {"Heavy rain": FluentIcons.weather_rain_48_regular},
    66: {"Light Freezing Rain": FluentIcons.weather_rain_snow_48_regular},
    67: {"Heavy Freezing Rain": FluentIcons.weather_rain_snow_48_regular},
    71: {"Slight snow fall": FluentIcons.weather_blowing_snow_48_regular},
    73: {"Moderate snow fall": FluentIcons.weather_blowing_snow_48_regular},
    75: {"Heavy snow fall": FluentIcons.weather_blowing_snow_48_regular},
    77: {"Snow grains": FluentIcons.weather_blowing_snow_48_regular},
    80: {"Slight rain showers": FluentIcons.weather_rain_showers_day_48_regular},
    81: {"Moderate rain showers": FluentIcons.weather_rain_showers_day_48_regular},
    82: {"Heavy rain showers": FluentIcons.weather_rain_showers_day_48_regular},
    85: {"Slight snow showers": FluentIcons.weather_snow_shower_day_48_regular},
    86: {"Heavy snow showers": FluentIcons.weather_snow_shower_day_48_regular},
    95: {"Thunderstorm": FluentIcons.weather_thunderstorm_48_regular},
    96: {"Slight thunderstorm hail": FluentIcons.weather_thunderstorm_48_regular},
    99: {"Heavy thunderstorm hail": FluentIcons.weather_thunderstorm_48_regular},
  };

  static String getSkyFromCode(int code) {
    Map<String, IconData> infos = wmoCodes[code] ?? {"No data": FluentIcons.error_circle_48_regular};
    return infos.keys.first;
  }

  static IconData getIconFromCode(int code) {
    Map<String, IconData> infos = wmoCodes[code] ?? {"No data": FluentIcons.error_circle_48_regular};
    return infos.values.first;
  }
}