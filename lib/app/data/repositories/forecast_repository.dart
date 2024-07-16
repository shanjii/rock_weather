import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/core/utils/coordinates.dart';

class ForecastRepository {
  ForecastRepository(
    this.networkDatasource,
    this.localDatasource,
  );
  final NetworkForecastDatasource networkDatasource;
  final LocalForecastDatasource localDatasource;

  Future<ForecastEntity> getCurrentForecast(Coordinates coordinates) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      final result = await networkDatasource.getCurrentForecast(coordinates);
      return result.toEntity();
    } else {
      final result = await localDatasource.getCurrentForecast(coordinates);
      return result.toEntity();
    }
  }

  Future<List<ForecastEntity>> getFutureForecast(
      Coordinates coordinates) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      final result = await networkDatasource.getFutureForecast(coordinates);
      return result.map((e) => e.toEntity()).toList();
    } else {
      final result = await localDatasource.getFutureForecast(coordinates);
      return result.map((e) => e.toEntity()).toList();
    }
  }
}
