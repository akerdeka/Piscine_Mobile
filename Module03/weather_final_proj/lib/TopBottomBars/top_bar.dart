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

  bool isUsingGps = false;

  Future<List<CityModel>> fetchListOfCities(String search) async {
    List<CityModel> filteredItems = [];
    try {
      http.Response res = await http.get(Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$search&count=5&language=en&format=json')).timeout(
        const Duration(seconds: 5),
        onTimeout: () {throw Exception("No connexion");}
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
      return Future.error("No connexion");
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AppBar(
        backgroundColor: Colors.transparent,
          actions: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
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
                        isUsingGps = false;
                        widget.onCityChanged(cities.first);
                      }
                    },
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.amber)
                        ),
                        hintText: 'Search location'
                    )
                );
              },
              itemBuilder: (context, city) {
                return ListTile(
                  leading: const Icon(Icons.location_city),
                  titleTextStyle: const TextStyle(fontSize: 20, color: Colors.amber),
                  title: Text(city.name),
                  subtitle: Text("${city.country}, ${city.region}"),
                );
              },
              onSelected: (city) {
                isUsingGps = false;
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
              isUsingGps = true;
              widget.onCityChanged(newCity);
            },
            icon: Container(child: isUsingGps ? Icon(Icons.gps_fixed, color: Colors.amber.shade600,) : const Icon(Icons.gps_not_fixed)))
      ]),
    );
  }
}
