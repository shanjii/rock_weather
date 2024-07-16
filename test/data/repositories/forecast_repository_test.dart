// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/repositories/forecast_repository.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/core/values/locations.dart';

late ForecastRepository repository;
late NetworkForecastDatasource networkDatasource;
late LocalForecastDatasource localDatasource;

void main() {
  setUp(() {
    networkDatasource = NetworkForecastDatasource();
    localDatasource = LocalForecastDatasource();
    repository = ForecastRepository(networkDatasource, localDatasource);
  });

  test("Should return ForecastEntity", () async {
    final result = await repository.getCurrentForecast(Locations.saoPaulo);
    print(result);
    expect(result, isA<ForecastEntity>());
  });

  test("Should return List<ForecastEntity>", () async {
    final result = await repository.getFutureForecast(Locations.saoPaulo);
    print(result);
    expect(result, isA<List<ForecastEntity>>());
  });
}
