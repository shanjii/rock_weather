import 'package:rock_weather/app/data/datasources/network/endpoints/base_endpoints.dart';
import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/rest/http_error_handler.dart';
import 'package:http/http.dart' as http;
import 'package:rock_weather/core/utils/coordinates.dart';

class NetworkForecastDatasource {
  Future<ForecastModel> getCurrentForecast(Coordinates coordinates) async {
    final response = await http.get(BaseEndpoints.current(coordinates));
    final body = HttpErrorHandler.handleResponse(response);
    return ForecastModel.fromJson(body);
  }

  Future<List<ForecastModel>> getFutureForecast(Coordinates coordinates) async {
    var response = await http.get(BaseEndpoints.future(coordinates));
    final body = HttpErrorHandler.handleListResponse(response);
    return body.map((e) => ForecastModel.fromJson(e)).toList();
  }
}
