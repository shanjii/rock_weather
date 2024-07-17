import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';

abstract class INetworkForecastDatasource {
  Future<Either<Failure, ForecastModel>> getCurrentForecast(
    LocationInfo info,
  );

  Future<Either<Failure, List<ForecastModel>>> getFutureForecast(
    LocationInfo info,
  );
}
