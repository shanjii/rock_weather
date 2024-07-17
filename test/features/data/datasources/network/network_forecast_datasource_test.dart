import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/data/datasources/network/i_network_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';
import '../../../../mocks/fake_forecast_factory.dart';

class MockClient extends Mock implements Client {}

void main() {
  late INetworkForecastDatasource datasource;
  late Client client;

  setUp(() {
    client = MockClient();
    datasource = NetworkForecastDatasource(client);
    registerFallbackValue(Uri.parse("https://example.com"));
  });

  void mockGet(response, int statusCode) {
    when(() => client.get(any())).thenAnswer(
      (_) async => Response(jsonEncode(response), statusCode),
    );
  }

  test("Should return [Right<Failure, ForecastModel>]", () async {
    mockGet(FakeCurrentForecastFactory.makeMap(), 200);
    final result = await datasource.getCurrentForecast(Locations.saoPaulo);
    expect(result, isA<Right<Failure, ForecastModel>>());
  });

  test("Should return [Right<Failure, List<ForecastModel>>]", () async {
    mockGet(FakeFutureForecastFactory.makeMap(), 200);
    final result = await datasource.getFutureForecast(Locations.saoPaulo);
    expect(result, isA<Right<Failure, List<ForecastModel>>>());
  });

  test("Should return [Left<Failure, ForecastModel>]", () async {
    mockGet(FakeCurrentForecastFactory.makeMap(), 404);
    final result = await datasource.getCurrentForecast(Locations.saoPaulo);
    expect(result, isA<Left<Failure, ForecastModel>>());
  });

  test("Should return Left<Failure, List<ForecastModel>>]", () async {
    mockGet(FakeFutureForecastFactory.makeMap(), 404);
    final result = await datasource.getFutureForecast(Locations.saoPaulo);
    expect(result, isA<Left<Failure, List<ForecastModel>>>());
  });
}
