import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/datasources/local/i_local_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/app/presentation/models/location.dart';
import 'package:rock_weather/core/cache/cache_error_handler.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalForecastDatasource implements ILocalForecastDatasource {
  LocalForecastDatasource(this.client);
  final SharedPreferences client;

  @override
  Future<Either<Failure, ForecastModel>> getCurrentForecast(
    Location location,
  ) async {
    try {
      final response = client.getString("current_${location.key}");

      final body = CacheErrorHandler.handleResponse(response);

      return Right<Failure, ForecastModel>(
        ForecastModel.fromJson(body),
      );
    } catch (e) {
      return const Left<Failure, ForecastModel>(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<ForecastModel>>> getFutureForecast(
    Location location,
  ) async {
    try {
      final response = client.getString("future_${location.key}");

      final body = CacheErrorHandler.handleListResponse(response);

      return Right<Failure, List<ForecastModel>>(
        body.map((e) => ForecastModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return const Left<Failure, List<ForecastModel>>(UnexpectedFailure());
    }
  }

  @override
  Future<void> setCurrentForecast(
    ForecastModel forecast,
    Location location,
  ) async {
    client.setString("current_${location.key}", jsonEncode(forecast.toJson()));
  }

  @override
  Future<void> setFutureForecast(
    List<ForecastModel> forecast,
    Location location,
  ) async {
    var listMap = forecast.map((e) => e.toJson()).toList();
    client.setString("future_${location.key}", jsonEncode(listMap));
  }
}
