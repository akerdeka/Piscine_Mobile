import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../weatherAppFinal_proj.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error(
          'Geolocation is not available, please enable it in your App settings');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    var error = false;

    return Future.error(
        "Geolocation is not available, please enable it in your App settings");
  }

  try {
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Future<Position> pos = Geolocator.getCurrentPosition();
    return await pos;
  } catch (error) {
    debugPrint(error.toString());
    return Future.error("Could not get position");
  }
}

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
