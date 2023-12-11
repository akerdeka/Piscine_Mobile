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
      {required this.onCityChanged, required this.errorTextChanged, super.key});

  final ValueChanged<CityModel?> onCityChanged;
  final ValueChanged<String> errorTextChanged;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  Future<List<CityModel>> fetchListOfCities(String search) async {
    List<CityModel> filteredItems = [];
    try {
      http.Response res = await http.get(Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$search&count=10&language=en&format=json')).timeout(
        const Duration(seconds: 5),
        onTimeout: () {throw Exception("The service connexion is lost, please check your internet connection or try again later");}
      );

      if (!jsonDecode(res.body).containsKey("results")) {
        return filteredItems;
      }

      for (dynamic location in jsonDecode(res.body)["results"]) {
        try {
          debugPrint(jsonEncode(location));
          filteredItems.add(CityModel(
              name: location["name"],
              region: location["admin1"] ?? location["admin2"] ?? location["admin3"] ?? location["admin4"] ?? "",
              country: location["country"],
              latitude: location["latitude"],
              longitude: location["longitude"]));
        } on Exception catch (e) {
          continue;
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error("The service connexion is lost, please check your internet connection or try again later");
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
              suggestionsCallback: (search) async {
                List<CityModel> list = [];
                try {
                  list = await fetchListOfCities(search);
                } catch (e) {
                  widget.errorTextChanged(e.toString());
                  debugPrint(e.toString());
                }
                return list;
              },
              errorBuilder: (context, error) => Text(error.toString()),
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
              late Position pos;
              try {
                pos = await determinePosition().onError((error, stackTrace) {
                  debugPrint(error.toString());
                  throw Exception(error);
                });
              } on Exception catch (e) {
                widget.onCityChanged(null);
                widget.errorTextChanged(e.toString().replaceAll("Exception: ", ""));
                return;
              }
              Placemark placemark = await getCityNameFromPosition(pos);
              CityModel newCity = CityModel(
                  name: placemark.locality!,
                  country: placemark.country!,
                  region: placemark.administrativeArea!,
                  longitude: pos.longitude,
                  latitude: pos.latitude);
              widget.onCityChanged(newCity);
            },
            icon: const Icon(Icons.map))
      ]),
    );
  }
}
