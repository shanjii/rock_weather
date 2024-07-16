class ForecastEntity {
  final int dt;
  final MainEntity main;
  final List<WeatherEntity> weather;
  final WindEntity wind;
  final int visibility;

  ForecastEntity({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
  });
}

class MainEntity {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
}

class WeatherEntity {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherEntity({this.id, this.main, this.description, this.icon});
}

class WindEntity {
  double? speed;
  int? deg;
  double? gust;

  WindEntity({this.speed, this.deg, this.gust});
}
