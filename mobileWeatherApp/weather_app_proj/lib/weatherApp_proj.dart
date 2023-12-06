import 'package:flutter/material.dart';
import 'package:mobile_weather_app/TopBottomBars/top_bar.dart';
import 'package:mobile_weather_app/Views/currently.dart';
import 'package:mobile_weather_app/Views/today.dart';
import 'package:mobile_weather_app/Views/weekly.dart';
import './TopBottomBars/bottom_bar.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherAppHome(),
    );
  }
}

class WeatherAppHome extends StatefulWidget {
  const WeatherAppHome({super.key});

  @override
  State<WeatherAppHome> createState() => _WeatherAppHomeState();
}

class _WeatherAppHomeState extends State<WeatherAppHome> {

  String _searchField = "";

  void _searchFieldChanged(String newValue) {
    setState(() {
      _searchField = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.square(50),
            child: TopBar(searchField: _searchField, onSearchChanged: _searchFieldChanged)
        ),
        body: Center(
          child: TabBarView(
            children: [CurrentlyView(localisation: _searchField), TodayView(localisation: _searchField), WeeklyView(localisation: _searchField)],
          ),
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
