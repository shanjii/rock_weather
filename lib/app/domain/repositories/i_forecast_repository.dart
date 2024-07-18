import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/models/location.dart';
import 'package:rock_weather/core/errors/failures.dart';

abstract class IForecastRepository {
  Future<Either<Failure, ForecastEntity>> getCurrentForecast(
    Location location,
  );
  Future<Either<Failure, List<ForecastEntity>>> getFutureForecast(
    Location location,
  );
}
