import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/app/presentation/models/location.dart';
import 'package:rock_weather/core/errors/failures.dart';

abstract class ILocalForecastDatasource {
  Future<Either<Failure, ForecastModel>> getCurrentForecast(Location location);
  Future<Either<Failure, List<ForecastModel>>> getFutureForecast(
      Location location);
  Future<void> setCurrentForecast(
    ForecastModel forecast,
    Location location,
  );
  Future<void> setFutureForecast(
    List<ForecastModel> forecast,
    Location location,
  );
}
