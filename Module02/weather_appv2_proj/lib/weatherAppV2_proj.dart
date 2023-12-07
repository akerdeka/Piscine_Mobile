import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:mobile_weather_app/TopBottomBars/top_bar.dart';
import 'package:mobile_weather_app/Views/currently.dart';
import 'package:mobile_weather_app/Views/today.dart';
import 'package:mobile_weather_app/Views/weekly.dart';
import './TopBottomBars/bottom_bar.dart';
import './TopBottomBars/geolocation.dart';
import 'Views/WeatherLogic/weather_getter.dart';
import 'Views/WeatherLogic/weather_model.dart';

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

  CityModel? _selectedCity;
  void _selectedCityChanged(CityModel newCity) {
    setState(() {
      _selectedCity = newCity;
    });
  }

  Future<WeatherModel> weather() async {
    await Future.delayed(const Duration(seconds: 1));

    return await WeatherGetter.getWeather(_selectedCity!);
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.square(50),
            child: TopBar(searchField: _searchField, onSearchChanged: _searchFieldChanged, onCityChanged: _selectedCityChanged,)
        ),
        body: Builder(
          builder: (BuildContext context) {
            if (_selectedCity != null) {
              return Center(
                  child: FutureBuilder(
                    future: weather(),
                    builder: (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(
                            child: LoadingAnimationWidget.fallingDot(
                                color: Colors.blue,
                                size: 100
                            ),
                          ),
                        );
                      }
                      else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Center(
                          child: TabBarView(
                            children: [
                              CurrentlyView(localisation: _selectedCity, data: snapshot.data),
                              TodayView(localisation: _selectedCity, data: snapshot.data),
                              WeeklyView(localisation: _selectedCity, data: snapshot.data)
                            ],
                          ),
                        );
                      }
                      else {
                        return Text(
                            'Error ${snapshot.error}'
                        );
                      }
                    },

                  )
              );
            } else {
              return const Center(child: Text('Currently\n'));
            }
          }
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
/*body: Center(
          child: TabBarView(
            children: [CurrentlyView(localisation: _selectedCity), TodayView(localisation: _selectedCity), WeeklyView(localisation: _selectedCity)],
          ),
        ),*/