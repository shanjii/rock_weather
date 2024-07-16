// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/values/locations.dart';

late NetworkForecastDatasource datasource;
void main() {
  setUp(() {
    datasource = NetworkForecastDatasource();
  });

  test("Should return ForecastModel", () async {
    final result = await datasource.getCurrentForecast(Locations.saoPaulo);
    print(result);
    expect(result, isA<ForecastModel>());
  });

  test("Should return List<ForecastModel>", () async {
    final result = await datasource.getFutureForecast(Locations.saoPaulo);
    print(result);
    expect(result, isA<List<ForecastModel>>());
  });
}
