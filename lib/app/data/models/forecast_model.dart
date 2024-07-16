import 'package:json_annotation/json_annotation.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/core/utils/mapper.dart';

part 'forecast_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ForecastModel extends Mapper<ForecastEntity> {
  int dt;
  MainModel main;
  List<WeatherModel> weather;
  WindModel wind;
  int visibility;

  ForecastModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
  });

  @override
  ForecastEntity toEntity() {
    return ForecastEntity(
      dt: dt,
      main: main.toEntity(),
      weather: weather.map((e) => e.toEntity()).toList(),
      wind: wind.toEntity(),
      visibility: visibility,
    );
  }

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);

  factory ForecastModel.fromJson(Map<String, dynamic> map) =>
      _$ForecastModelFromJson(map);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MainModel extends Mapper<MainEntity> {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainModel({
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

  @override
  MainEntity toEntity() {
    return MainEntity(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
      humidity: humidity,
      tempKf: tempKf,
    );
  }

  Map<String, dynamic> toJson() => _$MainModelToJson(this);

  factory MainModel.fromJson(Map<String, dynamic> map) =>
      _$MainModelFromJson(map);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WeatherModel extends Mapper<WeatherEntity> {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  WeatherEntity toEntity() {
    return WeatherEntity(
      id: id,
      main: main,
      description: description,
      icon: icon,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  factory WeatherModel.fromJson(Map<String, dynamic> map) =>
      _$WeatherModelFromJson(map);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class WindModel extends Mapper<WindEntity> {
  double? speed;
  int? deg;
  double? gust;

  WindModel({
    this.speed,
    this.deg,
    this.gust,
  });

  @override
  WindEntity toEntity() {
    return WindEntity(
      speed: speed,
      deg: deg,
      gust: gust,
    );
  }

  Map<String, dynamic> toJson() => _$WindModelToJson(this);

  factory WindModel.fromJson(Map<String, dynamic> map) =>
      _$WindModelFromJson(map);
}
