import 'package:rock_weather/app/domain/entities/forecast_entity.dart';

class DayForecast {
  final DateTime day;
  final List<ForecastEntity> hourlyForecast;

  DayForecast({required this.day, required this.hourlyForecast});
}
