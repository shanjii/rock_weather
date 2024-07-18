import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/repositories/forecast_repository.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/usecases/current_forecast_usecase.dart';
import 'package:rock_weather/app/presentation/common/constants.dart';
import 'package:rock_weather/app/presentation/models/city.dart';
import 'package:rock_weather/app/presentation/models/location.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/utils/convertions.dart';
import 'package:rock_weather/main.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    //Dependency injections
    currentForecastUsecase = CurrentForecastUsecase(
      ForecastRepository(
        NetworkForecastDatasource(Client()),
        LocalForecastDatasource(globalSharedPrefs),
      ),
    );
    //Initial function
    getAllCurrentWeather();
  }

  late CurrentForecastUsecase currentForecastUsecase;

  bool isLoading = false;

  List<City> filteredCities = [];
  List<City> allCities = [];

  getAllCurrentWeather() async {
    _setLoadingState(true);

    const locations = Constants.locations;

    List<Future<City>> requests = locations.map((e) {
      return getWeather(e);
    }).toList();

    allCities = await Future.wait(requests);
    filteredCities = allCities;

    _setLoadingState(false);
  }

  Future<City> getWeather(Location location) async {
    final result = await currentForecastUsecase(location);

    if (result is Right<Failure, ForecastEntity>) {
      return City(location: location, forecast: result.value);
    } else {
      return City(location: location, forecast: null);
    }
  }

  filterCities(String cityName) {
    if (cityName.isEmpty) {
      filteredCities = allCities;
    } else {
      final parsedName = Convertions.simplifyString(cityName);

      filteredCities = allCities.where((e) {
        final name = Convertions.simplifyString(e.location.name);
        return name.contains(parsedName);
      }).toList();
    }

    notifyListeners();
  }

  _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }
}
