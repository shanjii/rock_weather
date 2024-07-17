import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/repositories/forecast_repository.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/usecases/current_forecast_usecase.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/values/locations.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    currentForecastUsecase = CurrentForecastUsecase(
      ForecastRepository(
        NetworkForecastDatasource(Client()),
        LocalForecastDatasource(),
      ),
    );
    getAllCurrentWeather();
  }

  late CurrentForecastUsecase currentForecastUsecase;

  bool isLoading = true;

  List<ForecastEntity?> forecasts = [];

  final List<LocationInfo> locations = [
    Locations.silverstone,
    Locations.saoPaulo,
    Locations.melbourne,
    Locations.monteCarlo,
  ];

  getAllCurrentWeather() async {
    List<Future<ForecastEntity?>> requests = locations.map((e) {
      return getWeather(e);
    }).toList();

    forecasts = await Future.wait(requests);

    print(forecasts);

    isLoading = false;

    notifyListeners();
  }

  Future<ForecastEntity?> getWeather(LocationInfo info) async {
    final result = await currentForecastUsecase(info);
    if (result is Right<Failure, ForecastEntity>) {
      return result.value;
    } else {
      return null;
    }
  }
}
