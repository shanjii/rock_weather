import 'package:rock_weather/app/domain/entities/forecast_entity.dart';

class DayForecast {
  ///The model representing a list of [ForecastEntity] of a given day,
  ///Should receive a [DateTime] using the [day] parameter and a group of [ForecastEntity]
  ///representing multiple [ForecastEntity] during many hours of the day.
  DayForecast({required this.day, required this.hourlyForecast});

  final DateTime day;
  final List<ForecastEntity> hourlyForecast;
}
