import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/repositories/i_forecast_repository.dart';
import 'package:rock_weather/app/domain/usecases/current_forecast_usecase.dart';
import 'package:rock_weather/core/errors/failures.dart';
import '../../../mocks/fake_forecast_factory.dart';
import '../../../mocks/fake_location_factory.dart';

class MockForecastRepository extends Mock implements IForecastRepository {}

void main() {
  late CurrentForecastUsecase forecastUsecase;
  late IForecastRepository forecastRepository;
  late ForecastEntity forecastEntity;

  setUp(() {
    forecastRepository = MockForecastRepository();
    forecastUsecase = CurrentForecastUsecase(forecastRepository);
    forecastEntity = FakeNetworkCurrentForecastFactory.makeEntity();
  });

  void mockGet(Either<Failure, ForecastEntity> response) {
    when(() => forecastRepository.getCurrentForecast(
          FakeLocationFactory.location,
        )).thenAnswer((_) async => response);
  }

  test("CurrentForecast should return ForecastEntity", () async {
    mockGet(Right<Failure, ForecastEntity>(forecastEntity));
    final result = await forecastUsecase(FakeLocationFactory.location);
    expect(result, isA<Right<Failure, ForecastEntity>>());
  });

  test("CurrentForecast should return Failure", () async {
    mockGet(const Left<Failure, ForecastEntity>(UnexpectedFailure()));
    final result = await forecastUsecase(FakeLocationFactory.location);
    expect(result, isA<Left<Failure, ForecastEntity>>());
  });
}
