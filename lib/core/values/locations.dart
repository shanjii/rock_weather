import 'package:rock_weather/core/utils/coordinates.dart';

class Locations {
  static LocationInfo silverstone = LocationInfo(
    coordinates: Coordinates(lat: "-46.6334", lon: "-23.5507"),
    name: "Silverstone",
  );

  static LocationInfo saoPaulo = LocationInfo(
    coordinates: Coordinates(lat: "-46.6334", lon: "-23.5507"),
    name: "São Paulo",
  );

  static LocationInfo melbourne = LocationInfo(
    coordinates: Coordinates(lat: "-46.6334", lon: "-23.5507"),
    name: "Melbourne",
  );

  static LocationInfo monteCarlo = LocationInfo(
    coordinates: Coordinates(lat: "asd", lon: "asd"),
    name: "Monte Carlo",
  );
}

class LocationInfo {
  final Coordinates coordinates;
  final String name;

  LocationInfo({required this.coordinates, required this.name});
}
