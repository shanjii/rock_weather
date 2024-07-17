import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';

abstract class IForecastRepository {
  Future<Either<Failure, ForecastEntity>> getCurrentForecast(
    LocationInfo info,
  );
  Future<Either<Failure, List<ForecastEntity>>> getFutureForecast(
    LocationInfo info,
  );
}
