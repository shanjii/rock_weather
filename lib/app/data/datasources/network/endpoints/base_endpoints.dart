import 'package:rock_weather/core/utils/coordinates.dart';

class BaseEndpoints {
  static String baseUrl = "https://api.openweathermap.org/data/2.5";
  static String apiKey = "b4791cdefa215c2ea7441b343696f520";

  static Uri current(Coordinates coordinates) => Uri.parse(
        '$baseUrl/weather?lat=${coordinates.lat}&lon=${coordinates.lon}&appid=$apiKey&units=metric',
      );

  static Uri future(Coordinates coordinates) => Uri.parse(
        '$baseUrl/forecast?lat=${coordinates.lat}&lon=${coordinates.lon}&appid=$apiKey&units=metric',
      );
}
