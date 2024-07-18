import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/repositories/forecast_repository.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../mocks/fake_forecast_factory.dart';
import '../../../mocks/fake_location_factory.dart';

class MockClient extends Mock implements Client {}

class MockPrefs extends Mock implements SharedPreferences {}

void main() {
  late NetworkForecastDatasource networkDatasource;
  late LocalForecastDatasource localDatasource;
  late ForecastRepository repository;
  late Client client;
  late SharedPreferences prefs;

  setUp(() async {
    client = MockClient();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    networkDatasource = NetworkForecastDatasource(client);
    localDatasource = LocalForecastDatasource(prefs);
    repository = ForecastRepository(networkDatasource, localDatasource);
    registerFallbackValue(Uri.parse("https://example.com"));
  });

  void mockGetNetwork(response, int statusCode) {
    when(() => client.get(any())).thenAnswer(
      (_) async => Response(jsonEncode(response), statusCode),
    );
  }

  test("NetworkCurrentForecast should return ForecastEntity", () async {
    mockGetNetwork(FakeNetworkCurrentForecastFactory.makeMap(), 200);
    final result = await repository.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, ForecastEntity>>());
  });

  test("LocalCurrentForecast should return ForecastEntity", () async {
    mockGetNetwork(FakeNetworkCurrentForecastFactory.makeMap(), 200);
    var result = await repository.getCurrentForecast(
      FakeLocationFactory.location,
    );
    mockGetNetwork(FakeNetworkCurrentForecastFactory.makeMap(), 404);
    result = await repository.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, ForecastEntity>>());
  });

  test("NetworkCurrentForecast should return Failure", () async {
    mockGetNetwork(FakeNetworkCurrentForecastFactory.makeMap(), 404);
    var result = await repository.getCurrentForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, ForecastEntity>>());
  });

  test("NetworkFutureForecast should return List<ForecastEntity>", () async {
    mockGetNetwork(FakeNetworkFutureForecastFactory.makeMap(), 200);
    final result = await repository.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, List<ForecastEntity>>>());
  });

  test("LocalFutureForecast should return List<ForecastEntity>", () async {
    mockGetNetwork(FakeNetworkFutureForecastFactory.makeMap(), 200);
    var result = await repository.getFutureForecast(
      FakeLocationFactory.location,
    );
    mockGetNetwork(FakeNetworkFutureForecastFactory.makeMap(), 404);
    result = await repository.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Right<Failure, List<ForecastEntity>>>());
  });

  test('NetworkFutureForecast should return Failure', () async {
    mockGetNetwork(FakeNetworkFutureForecastFactory.makeMap(), 404);
    final result = await repository.getFutureForecast(
      FakeLocationFactory.location,
    );
    expect(result, isA<Left<Failure, List<ForecastEntity>>>());
  });
}
