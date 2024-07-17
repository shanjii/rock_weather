import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/datasources/local/i_local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/i_network_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/repositories/i_forecast_repository.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';

class ForecastRepository implements IForecastRepository {
  ForecastRepository(
    this.networkDatasource,
    this.localDatasource,
  );

  final INetworkForecastDatasource networkDatasource;
  final ILocalForecastDatasource localDatasource;

  @override
  Future<Either<Failure, ForecastEntity>> getCurrentForecast(
    LocationInfo info,
  ) async {
    final network = await networkDatasource.getCurrentForecast(info);
    if (network is Right<Failure, ForecastModel>) {
      return Right<Failure, ForecastEntity>(network.value.toEntity());
    }

    final local = await localDatasource.getCurrentForecast(info);
    if (local is Right<Failure, ForecastModel>) {
      return Right<Failure, ForecastEntity>(
        local.value.toEntity(),
      );
    }

    return const Left<Failure, ForecastEntity>(UnexpectedFailure());
  }

  @override
  Future<Either<Failure, List<ForecastEntity>>> getFutureForecast(
    LocationInfo info,
  ) async {
    final network = await networkDatasource.getFutureForecast(info);
    if (network is Right<Failure, List<ForecastModel>>) {
      return Right<Failure, List<ForecastEntity>>(
        network.value.map((e) => e.toEntity()).toList(),
      );
    }

    final local = await localDatasource.getFutureForecast(info);
    if (local is Right<Failure, List<ForecastModel>>) {
      return Right<Failure, List<ForecastEntity>>(
        local.value.map((e) => e.toEntity()).toList(),
      );
    }

    return const Left<Failure, List<ForecastEntity>>(UnexpectedFailure());
  }
}
