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
import 'package:rock_weather/core/values/locations.dart';
import '../../../mocks/fake_forecast_factory.dart';

class MockClient extends Mock implements Client {}

void main() {
  late NetworkForecastDatasource networkDatasource;
  late LocalForecastDatasource localDatasource;
  late ForecastRepository repository;
  late Client client;

  setUp(() {
    client = MockClient();
    networkDatasource = NetworkForecastDatasource(client);
    localDatasource = LocalForecastDatasource();
    repository = ForecastRepository(networkDatasource, localDatasource);
    registerFallbackValue(Uri.parse("https://example.com"));
  });

  void mockGet(response, int statusCode) {
    when(() => client.get(any())).thenAnswer(
      (_) async => Response(jsonEncode(response), statusCode),
    );
  }

  test("Should return Right<Failure, ForecastEntity>", () async {
    mockGet(FakeCurrentForecastFactory.makeMap(), 200);
    final result = await repository.getCurrentForecast(Locations.saoPaulo);
    expect(result, isA<Right<Failure, ForecastEntity>>());
  });

  test("Should return [Right<Failure, List<ForecastEntity>>]", () async {
    mockGet(FakeFutureForecastFactory.makeMap(), 200);
    final result = await repository.getFutureForecast(Locations.saoPaulo);
    expect(result, isA<Right<Failure, List<ForecastEntity>>>());
  });

  test("Should return [Left<Failure, ForecastEntity>]", () async {
    mockGet(FakeCurrentForecastFactory.makeMap(), 404);
    final result = await repository.getCurrentForecast(Locations.saoPaulo);
    expect(result, isA<Left<Failure, ForecastEntity>>());
  });

  test('Should return [Left<Failure, List<ForecastEntity>>]', () async {
    mockGet(FakeCurrentForecastFactory.makeMap(), 404);
    final result = await repository.getFutureForecast(Locations.saoPaulo);
    expect(result, isA<Left<Failure, List<ForecastEntity>>>());
  });
}
