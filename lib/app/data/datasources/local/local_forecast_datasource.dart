import 'package:rock_weather/app/data/models/forecast_model.dart';
import 'package:rock_weather/core/utils/coordinates.dart';

class LocalForecastDatasource {
  Future<ForecastModel> getCurrentForecast(Coordinates coordinates) {
    // return ForecastModel.fromJson(body);
    throw UnimplementedError();
  }

  Future<List<ForecastModel>> getFutureForecast(Coordinates coordinates) {
    // return body.map((e) => ForecastModel.fromJson(e)).toList();
    throw UnimplementedError();
  }
}
