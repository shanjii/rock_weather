import 'package:flutter_test/flutter_test.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import '../../../mocks/fake_forecast_factory.dart';

void main() {
  final forecastEntity = FakeLocalCurrentForecastFactory.makeEntity();

  test('Should be a ForecastEntity', () {
    expect(forecastEntity, isA<ForecastEntity>());
  });
}
