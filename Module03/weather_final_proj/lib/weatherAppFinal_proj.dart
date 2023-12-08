import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:mobile_weather_app/TopBottomBars/top_bar.dart';
import 'package:mobile_weather_app/Views/currently.dart';
import 'package:mobile_weather_app/Views/today.dart';
import 'package:mobile_weather_app/Views/weekly.dart';
import './TopBottomBars/bottom_bar.dart';
import './TopBottomBars/top_bar.dart';
import './TopBottomBars/geolocation.dart';
import 'Views/WeatherLogic/weather_getter.dart';
import 'Views/WeatherLogic/weather_model.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  CityModel? _selectedCity;

  void _selectedCityChanged(CityModel? newCity) {
    setState(() {
      _selectedCity = newCity;
    });
  }

  bool _hasPos = false;

  Future<CityModel> getPosition() async {
    await Future.delayed(const Duration(seconds: 1));

    Position pos = await determinePosition();
    _hasPos = true;
    Placemark placemark = await getCityNameFromPosition(pos);
    CityModel newCity = CityModel(
        name: placemark.locality!,
        country: placemark.country!,
        region: placemark.administrativeArea!,
        longitude: pos.longitude,
        latitude: pos.latitude);
    _selectedCityChanged(newCity);
    return newCity;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _hasPos == false ? getPosition() : null,
          builder: (BuildContext context,
              AsyncSnapshot<CityModel> snapshot) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/Images/Weather_clear.jpeg"),
                      fit: BoxFit.cover
                  )
              ),
              child: WeatherAppHome(
                  selectedCity: _selectedCity,
                  onCityChanged: _selectedCityChanged
              ),
            );
          }
      ),
    );
  }
}

class WeatherAppHome extends StatefulWidget {
  const WeatherAppHome({required this.selectedCity, required this.onCityChanged, super.key});

  final CityModel? selectedCity;
  final ValueChanged<CityModel?> onCityChanged;


  @override
  State<WeatherAppHome> createState() => _WeatherAppHomeState();
}

class _WeatherAppHomeState extends State<WeatherAppHome> {
  Future<WeatherModel> weather() async {
    await Future.delayed(const Duration(seconds: 1));

    return await WeatherGetter.getWeatherByCityModel(widget.selectedCity!).onError((error, stackTrace) {
      return Future.error("Can't get le weather, please check your connexion");
    });
  }

  String errorText = "";
  void _setError(String value) {
    setState(() {
      errorText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.square(50),
            child: TopBar(
              onCityChanged: widget.onCityChanged,
              errorTextChanged: _setError,
            )),
        body: Builder(builder: (BuildContext context) {
          if (widget.selectedCity != null) {
            return Center(
                child: FutureBuilder(
                  future: weather(),
                  builder: (BuildContext context,
                      AsyncSnapshot<WeatherModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: LoadingAnimationWidget.fallingDot(
                              color: Colors.blue, size: 100),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done &&
                        snapshot.hasData) {
                      return Center(
                        child: TabBarView(
                          children: [
                            CurrentlyView(
                                localisation: widget.selectedCity,
                                data: snapshot.data),
                            TodayView(
                                localisation: widget.selectedCity,
                                data: snapshot.data),
                            WeeklyView(
                                localisation: widget.selectedCity,
                                data: snapshot.data)
                          ],
                        ),
                      );
                    } else {
                      return TabBarView(children: [
                        Center(child: Text('Error: ${snapshot.error}')),
                        Center(child: Text('Error: ${snapshot.error}')),
                        Center(child: Text('Error: ${snapshot.error}'))],);
                    }
                  },
                ));
          } else {
            return errorText.isEmpty ? const Center(child: Text("No position")) :
            Center(child: Text(errorText));
          }
        }),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
