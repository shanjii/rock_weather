import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';

import '../../../mocks/fake_forecast_factory.dart';

void main() {
  final forecastModel = FakeLocalCurrentForecastFactory.makeModel();
  final forecastMock = FakeLocalCurrentForecastFactory.makeMap();

  test('Should be a ForecastModel', () {
    expect(forecastModel, isA<ForecastModel>());
  });

  test('Should return a valid model', () {
    final result = ForecastModel.fromJson(forecastMock);
    expect(result, isA<ForecastModel>());
  });

  test('Should return a valid entity', () {
    final result = forecastModel.toEntity();
    expect(result, isA<ForecastEntity>());
  });

  test('Should return a json map containing the proper data', () {
    final result = forecastModel.toJson();
    expect(forecastMock, result);
  });
}
