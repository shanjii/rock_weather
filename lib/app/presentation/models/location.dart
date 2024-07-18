import 'package:rock_weather/app/presentation/models/coordinates.dart';

class Location {
  const Location({
    required this.coordinates,
    required this.name,
    required this.key,
  });

  final Coordinates coordinates;
  final String name;
  final String key;
}
