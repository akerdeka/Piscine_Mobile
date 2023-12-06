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
      {required this.searchField, required this.onSearchChanged, super.key});

  final String searchField;
  final ValueChanged<String> onSearchChanged;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {


  Future<List<Placemark>> getCityNameFromPosition(Position localisation) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        localisation.latitude,
        localisation.longitude,
      );

      return placemarks;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<List<CityModel>> fetchListOfCities(String search) async {

    http.Response res = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$search&count=20&language=en&format=json'));

    List<CityModel> filteredItems = [];

    if (!jsonDecode(res.body).containsKey("results")){
      return filteredItems;
    }

    for (dynamic location in jsonDecode(res.body)["results"]) {
      debugPrint(location.toString());
      filteredItems.add(CityModel(name: location.name, region: location.admin1, country: location.country));
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: (search) => fetchListOfCities(search),
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City'
            )
        );
      },
      itemBuilder: (context, city) {
        return ListTile(
          title: Text(city.name),
          subtitle: Text(city.country),
        );
      },
      onSelected: (city) {
        debugPrint(city.toString());
      },
    );
  }
}
