import 'package:rock_weather/app/presentation/models/coordinates.dart';
import 'package:rock_weather/app/presentation/models/location.dart';

class FakeLocationFactory {
  static const location = Location(
    coordinates: Coordinates(lat: "-23.5475", lon: "-46.6361"),
    name: "Test",
    key: "test",
  );
}
