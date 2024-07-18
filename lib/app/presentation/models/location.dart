import 'package:rock_weather/app/presentation/models/coordinates.dart';

class Location {
  final Coordinates coordinates;
  final String name;
  final String key;

  const Location({
    required this.coordinates,
    required this.name,
    required this.key,
  });
}
