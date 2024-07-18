import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/models/location.dart';

class City {
  final Location location;
  final ForecastEntity? forecast;

  City({required this.location, required this.forecast});
}
