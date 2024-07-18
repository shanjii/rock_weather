import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/models/location.dart';

class City {
  ///A city model that combines a [Location] with a [ForecastEntity].
  City({required this.location, required this.forecast});

  final Location location;
  final ForecastEntity? forecast;
}
