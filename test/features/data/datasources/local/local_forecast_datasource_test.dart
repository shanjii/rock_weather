import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/data/datasources/local/i_local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../mocks/fake_forecast_factory.dart';
import '../../../../mocks/fake_location_factory.dart';

class MockPreferences extends Mock implements SharedPreferences {}

void main() {
  late ILocalForecastDatasource datasource;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = MockPreferences();
    datasource = LocalForecastDatasource(prefs);
    registerFallbackValue(Uri.parse("https://example.com"));
  });

  void mockGet(response) {
    when(() => prefs.getString(any())).thenAnswer(
      (_) => jsonEncode(response),
    );
  }

  test("LocalCurrentForecast should return ForecastModel", () async {
    mockGet(FakeLocalCurrentForecastFactory.makeMap());
    final result = await datasource.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, ForecastModel>>());
  });

  test("LocalCurrentForecast should return Failure", () async {
    mockGet(null);
    final result = await datasource.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, ForecastModel>>());
  });

  test("LocalFutureForecast should return List<ForecastModel>", () async {
    mockGet(FakeLocalFutureForecastFactory.makeMap());
    final result = await datasource.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, List<ForecastModel>>>());
  });

  test("LocalFutureForecast should return Failure", () async {
    mockGet(null);
    final result = await datasource.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, List<ForecastModel>>>());
  });
}
