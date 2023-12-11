import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/Views/WeatherLogic/weather_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                      primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.days,
                          interval: 1,
                          labelStyle: const TextStyle(color: Colors.amber)),
                      primaryYAxis: NumericAxis(
                          interval: 0.5,
                          labelStyle: const TextStyle(color: Colors.amber)),

                      legend: Legend(isVisible: true, position: LegendPosition.bottom),
                      series: <ChartSeries>[

                        // Renders line chart
                        LineSeries<DailyModel, DateTime>(
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                            ),
                            enableTooltip: false,
                            width: 5,
                            name: "Max temp.",
                            color: Colors.amber[900],
                            opacity: 1,
                            dataSource: widget.data!.weekly,
                            xValueMapper: (DailyModel data, _) =>
                                DateTime.parse(data.date),
                            yValueMapper: (DailyModel data, _) =>
                                double.parse(data.maxTemp)
                        ),

                        LineSeries<DailyModel, DateTime>(
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                            ),
                            enableTooltip: false,
                            width: 5,
                            name: "Min temp.",
                            color: Colors.amber[100],
                            opacity: 1,
                            dataSource: widget.data!.weekly,
                            xValueMapper: (DailyModel data, _) =>
                                DateTime.parse(data.date),
                            yValueMapper: (DailyModel data, _) =>
                                double.parse(data.minTemp)
                        ),
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
                  children: widget.data!.weekly
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
                            Text(item.date),
                            Icon(WmoWeatherCodes.getIconFromCode(item.weatherDescription), color: Colors.amber),
                            Text('${item.maxTemp} °C', style: TextStyle(color: Colors.amber[900])),
                            Text('${item.minTemp} °C', style: TextStyle(color: Colors.amber[100]),)
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
