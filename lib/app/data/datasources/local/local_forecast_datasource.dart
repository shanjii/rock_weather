import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/datasources/local/i_local_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';

class LocalForecastDatasource implements ILocalForecastDatasource {
  @override
  Future<Either<Failure, ForecastModel>> getCurrentForecast(
    LocationInfo info,
  ) async {
    // return ForecastModel.fromJson(body);
    return const Left<Failure, ForecastModel>(UnexpectedFailure());
  }

  @override
  Future<Either<Failure, List<ForecastModel>>> getFutureForecast(
    LocationInfo info,
  ) async {
    // return body.map((e) => ForecastModel.fromJson(e)).toList();
    return const Left<Failure, List<ForecastModel>>(UnexpectedFailure());
  }
}
