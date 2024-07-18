import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';

class FakeLocalFutureForecastFactory {
  static List<Map<String, dynamic>> makeMap() =>
      [FakeLocalCurrentForecastFactory.makeMap()];
}

class FakeLocalCurrentForecastFactory {
  static ForecastModel makeModel() => ForecastModel(
        dt: 1,
        main: _FakeMainFactory.makeModel(),
        weather: [_FakeWeatherFactory.makeModel()],
        wind: _FakeWindFactory.makeModel(),
        visibility: 1,
      );

  static ForecastEntity makeEntity() => ForecastEntity(
        dt: 1,
        main: _FakeMainFactory.makeEntity(),
        weather: [_FakeWeatherFactory.makeEntity()],
        wind: _FakeWindFactory.makeEntity(),
        visibility: 1,
      );

  static Map<String, dynamic> makeMap() => {
        'dt': 1,
        'main': _FakeMainFactory.makeMap(),
        'weather': [_FakeWeatherFactory.makeMap()],
        'wind': _FakeWindFactory.makeMap(),
        'visibility': 1,
      };
}

class FakeNetworkFutureForecastFactory {
  static List<ForecastEntity> makeEntity() => [
        ForecastEntity(
          dt: 1,
          main: _FakeMainFactory.makeEntity(),
          weather: [_FakeWeatherFactory.makeEntity()],
          wind: _FakeWindFactory.makeEntity(),
          visibility: 1,
        ),
      ];

  static Map<String, dynamic> makeMap() => {
        'list': [FakeNetworkCurrentForecastFactory.makeMap()],
      };
}

class FakeNetworkCurrentForecastFactory {
  static ForecastModel makeModel() => ForecastModel(
        dt: 1,
        main: _FakeMainFactory.makeModel(),
        weather: [_FakeWeatherFactory.makeModel()],
        wind: _FakeWindFactory.makeModel(),
        visibility: 1,
      );

  static ForecastEntity makeEntity() => ForecastEntity(
        dt: 1,
        main: _FakeMainFactory.makeEntity(),
        weather: [_FakeWeatherFactory.makeEntity()],
        wind: _FakeWindFactory.makeEntity(),
        visibility: 1,
      );

  static Map<String, dynamic> makeMap() => {
        'dt': 1,
        'main': _FakeMainFactory.makeMap(),
        'weather': [_FakeWeatherFactory.makeMap()],
        'wind': _FakeWindFactory.makeMap(),
        'visibility': 1,
      };
}

class _FakeMainFactory {
  static MainModel makeModel() => MainModel(
        temp: 1,
        feelsLike: 1,
        tempMin: 1,
        tempMax: 1,
        pressure: 1,
        seaLevel: 1,
        grndLevel: 1,
        humidity: 1,
        tempKf: 1,
      );

  static MainEntity makeEntity() => MainEntity(
        temp: 1,
        feelsLike: 1,
        tempMin: 1,
        tempMax: 1,
        pressure: 1,
        seaLevel: 1,
        grndLevel: 1,
        humidity: 1,
        tempKf: 1,
      );

  static Map<String, dynamic> makeMap() => {
        'temp': 1,
        'feels_like': 1,
        'temp_min': 1,
        'temp_max': 1,
        'pressure': 1,
        'sea_level': 1,
        'grnd_level': 1,
        'humidity': 1,
        'temp_kf': 1,
      };
}

class _FakeWeatherFactory {
  static WeatherModel makeModel() => WeatherModel(
        id: 1,
        main: "string",
        description: "string",
        icon: "string",
      );

  static WeatherEntity makeEntity() => WeatherEntity(
        id: 1,
        main: "string",
        description: "string",
        icon: "string",
      );

  static Map<String, dynamic> makeMap() => {
        'id': 1,
        'main': "string",
        'description': "string",
        'icon': "string",
      };
}

class _FakeWindFactory {
  static WindModel makeModel() => WindModel(
        speed: 1,
        deg: 1,
        gust: 1,
      );

  static WindEntity makeEntity() => WindEntity(
        speed: 1,
        deg: 1,
        gust: 1,
      );

  static Map<String, dynamic> makeMap() => {
        'speed': 1,
        'deg': 1,
        'gust': 1,
      };
}
