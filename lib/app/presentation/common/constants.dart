import 'package:flutter/material.dart';
import 'package:rock_weather/app/presentation/models/coordinates.dart';
import 'package:rock_weather/app/presentation/models/location.dart';

class Constants {
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(16));

  static const defaultRectangleBorder = RoundedRectangleBorder(
    side: BorderSide.none,
    borderRadius: defaultBorderRadius,
  );

  static const locations = [
    Location(
      coordinates: Coordinates(lat: "52.0922", lon: "-1.026"),
      name: "Silverstone",
      key: "silverstone",
    ),
    Location(
      coordinates: Coordinates(lat: "-23.5475", lon: "-46.6361"),
      name: "São Paulo",
      key: "saopaulo",
    ),
    Location(
      coordinates: Coordinates(lat: "28.0836", lon: "-80.6081"),
      name: "Melbourne",
      key: "melbourne",
    ),
    Location(
      coordinates: Coordinates(lat: "43.7496", lon: "7.437"),
      name: "Monte Carlo",
      key: "montecarlo",
    ),
  ];
}
