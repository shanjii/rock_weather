import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/data/datasources/network/endpoints/base_endpoints.dart';
import 'package:rock_weather/app/data/datasources/network/i_network_forecast_datasource.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/rest/http_error_handler.dart';
import 'package:http/http.dart';
import 'package:rock_weather/core/values/locations.dart';

class NetworkForecastDatasource implements INetworkForecastDatasource {
  NetworkForecastDatasource(this.client);

  final Client client;

  @override
  Future<Either<Failure, ForecastModel>> getCurrentForecast(
    LocationInfo info,
  ) async {
    try {
      final response = await client.get(
        BaseEndpoints.current(info.coordinates),
      );
      final body = HttpErrorHandler.handleResponse(response);

      return Right<Failure, ForecastModel>(
        ForecastModel.fromJson(body),
      );
    } catch (e) {
      return const Left<Failure, ForecastModel>(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<ForecastModel>>> getFutureForecast(
    LocationInfo info,
  ) async {
    try {
      final response = await client.get(
        BaseEndpoints.future(info.coordinates),
      );
      final body = HttpErrorHandler.handleListResponse(response);

      return Right<Failure, List<ForecastModel>>(
        body.map((e) => ForecastModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return const Left<Failure, List<ForecastModel>>(UnexpectedFailure());
    }
  }
}
