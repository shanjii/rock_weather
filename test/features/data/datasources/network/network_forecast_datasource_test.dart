import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/data/datasources/network/i_network_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import '../../../../mocks/fake_forecast_factory.dart';
import '../../../../mocks/fake_location_factory.dart';

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

  test("NetworkCurrentForecast should return ForecastModel", () async {
    mockGet(FakeNetworkCurrentForecastFactory.makeMap(), 200);
    final result = await datasource.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, ForecastModel>>());
  });

  test("NetworkCurrentForecast should return Failure", () async {
    mockGet(FakeNetworkCurrentForecastFactory.makeMap(), 404);
    final result = await datasource.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, ForecastModel>>());
  });

  test("NetworkFutureForecast should return List<ForecastModel>", () async {
    mockGet(FakeNetworkFutureForecastFactory.makeMap(), 200);
    final result = await datasource.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, List<ForecastModel>>>());
  });

  test("NetworkFutureForecast should return Failure", () async {
    mockGet(FakeNetworkFutureForecastFactory.makeMap(), 404);
    final result = await datasource.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, List<ForecastModel>>>());
  });
}
