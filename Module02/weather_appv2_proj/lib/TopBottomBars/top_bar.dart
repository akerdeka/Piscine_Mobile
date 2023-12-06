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
  List<CityModel> filteredItems = [];

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

  Future<http.Response> fetchListOfCities(String search) async {
    http.Response res = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$search&count=20&language=en&format=json'));

    //debugPrint(jsonDecode(res.body));
    filteredItems.add(const CityModel(name: "Lyon"));

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 40,
                child: SearchBar(
                  leading: const Icon(Icons.search),
                  onChanged: (String value) async {
                    await fetchListOfCities(value);
                    widget.onSearchChanged(value);
                  },
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () => {
                    determinePosition()
                        .then((value) => {
                              getCityNameFromPosition(value).then((res) => {
                                    debugPrint(res.toString()),
                                  }),
                              widget.onSearchChanged(
                                  "${value.latitude} ${value.longitude}")
                            })
                        .onError((error, stackTrace) =>
                            {widget.onSearchChanged("$error")}),
                  },
              icon: const Icon(Icons.map))
        ],
      ),
      body: filteredItems.isEmpty
          ? const Center(
              child: Text(
                'No Results Found',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index].name),
                );
              },
            ),
    );
  }
}
