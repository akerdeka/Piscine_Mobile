import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../utils/wmo_weather_codes.dart';
import 'dart:math';

class TodayView extends StatefulWidget {
  const TodayView({required this.localisation, required this.data, super.key});

  final CityModel? localisation;
  final WeatherModel? data;

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.localisation != null) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Column(
                      children: [
                        Text(widget.localisation!.name,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold)),
                        Text(
                            '${widget.localisation!.country}, ${widget.localisation!.region}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                      primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.hours,
                          interval: 2,
                          labelStyle: const TextStyle(color: Colors.amber)),
                      primaryYAxis: NumericAxis(
                          interval: 0.5,
                          visibleMaximum:
                              WeatherModel.getMaxTemp(widget.data!.daily)
                                  .ceilToDouble(),
                          visibleMinimum:
                              WeatherModel.getMinTemp(widget.data!.daily)
                                  .floorToDouble(),
                          labelStyle: const TextStyle(color: Colors.amber)),
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<HourlyModel, DateTime>(
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                            ),
                            enableTooltip: false,
                            width: 5,
                            color: Colors.amber,
                            opacity: 1,
                            dataSource: widget.data!.daily,
                            xValueMapper: (HourlyModel data, _) =>
                                DateTime.parse(data.time),
                            yValueMapper: (HourlyModel data, _) =>
                                double.parse(data.temperature))
                      ]),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.data!.daily
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.time
                                        .substring(11, item.time.length), style: TextStyle(color: Colors.white),),
                                    Text(
                                      '${item.temperature} °C',
                                      style: const TextStyle(color: Colors.amber),
                                    ),
                                    Icon(
                                      WmoWeatherCodes.getIconFromCode(
                                          item.weatherDescription),
                                      color: Colors.amber,
                                    ),
                                    Text('${item.windSpeed} km/h', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const Center(child: Text('No Localisation\n'));
  }
}
