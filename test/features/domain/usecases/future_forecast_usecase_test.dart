import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/repositories/i_forecast_repository.dart';
import 'package:rock_weather/app/domain/usecases/future_forecast_usecase.dart';
import 'package:rock_weather/core/errors/failures.dart';
import '../../../mocks/fake_forecast_factory.dart';
import '../../../mocks/fake_location_factory.dart';

class MockForecastRepository extends Mock implements IForecastRepository {}

void main() {
  late FutureForecastUsecase forecastUsecase;
  late IForecastRepository forecastRepository;
  late List<ForecastEntity> forecastEntity;

  setUp(() {
    forecastRepository = MockForecastRepository();
    forecastUsecase = FutureForecastUsecase(forecastRepository);
    forecastEntity = FakeNetworkFutureForecastFactory.makeEntity();
  });

  void mockGet(Either<Failure, List<ForecastEntity>> response) {
    when(() => forecastRepository.getFutureForecast(
          FakeLocationFactory.location,
        )).thenAnswer((_) async => response);
  }

  test("FutureForecast should return List<ForecastEntity>", () async {
    mockGet(Right<Failure, List<ForecastEntity>>(forecastEntity));
    final result = await forecastUsecase(FakeLocationFactory.location);
    expect(result, isA<Right<Failure, List<ForecastEntity>>>());
  });

  test("FutureForecast should return Failure", () async {
    mockGet(const Left<Failure, List<ForecastEntity>>(UnexpectedFailure()));
    final result = await forecastUsecase(FakeLocationFactory.location);
    expect(result, isA<Left<Failure, List<ForecastEntity>>>());
  });
}
