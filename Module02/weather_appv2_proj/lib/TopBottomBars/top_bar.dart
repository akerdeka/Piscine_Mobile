import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/TopBottomBars/city_model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import './geolocation.dart';

class TopBar extends StatefulWidget {
  const TopBar(
      {required this.searchField,
      required this.onSearchChanged,
      required this.onCityChanged,
      super.key});

  final String searchField;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<CityModel> onCityChanged;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  Future<Placemark> getCityNameFromPosition(Position localisation) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        localisation.latitude,
        localisation.longitude,
      );

      debugPrint(jsonEncode(placemarks.first));
      return placemarks.first;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<List<CityModel>> fetchListOfCities(String search) async {
    http.Response res = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$search&count=10&language=en&format=json'));

    List<CityModel> filteredItems = [];

    if (!jsonDecode(res.body).containsKey("results")) {
      return filteredItems;
    }

    for (dynamic location in jsonDecode(res.body)["results"]) {
      try {
        debugPrint(jsonEncode(location));
        filteredItems.add(CityModel(
            name: location["name"],
            region: location["admin1"],
            country: location["country"],
            latitude: location["latitude"],
            longitude: location["longitude"]));
      } on Exception catch (e) {
        continue;
      }
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: TypeAheadField(
              hideOnEmpty: false,
              suggestionsCallback: (search) => fetchListOfCities(search),
              builder: (context, controller, focusNode) {
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: false,
                    onSubmitted: (String text) async {
                      List<CityModel> cities = await fetchListOfCities(text);
                      if (cities.isNotEmpty) {
                        widget.onCityChanged(cities.first);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'City'));
              },
              itemBuilder: (context, city) {
                return ListTile(
                  title: Text(city.name),
                  subtitle: Text("${city.country}, ${city.region}"),
                );
              },
              onSelected: (city) {
                widget.onCityChanged(city);
              },
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              try {
                Position pos = await determinePosition();
                Placemark placemark = await getCityNameFromPosition(pos);
                CityModel newCity = CityModel(
                    name: placemark.locality!,
                    country: placemark.country!,
                    region: placemark.administrativeArea!,
                    longitude: pos.longitude,
                    latitude: pos.latitude);
                widget.onCityChanged(newCity);
              } on Exception catch (e) {
                debugPrint(e.toString());
              }
            },
            icon: const Icon(Icons.map))
      ]),
    );
  }
}
