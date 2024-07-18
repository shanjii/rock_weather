import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:rock_weather/app/data/datasources/local/local_forecast_datasource.dart';
import 'package:rock_weather/app/data/datasources/network/network_forecast_datasource.dart';
import 'package:rock_weather/app/data/repositories/forecast_repository.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/usecases/future_forecast_usecase.dart';
import 'package:rock_weather/app/presentation/models/city.dart';
import 'package:rock_weather/app/presentation/models/day_forecast.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/utils/convertions.dart';
import 'package:rock_weather/main.dart';

class DetailsController with ChangeNotifier {
  DetailsController({required this.city}) {
    //Dependency injection
    futureForecastUsecase = FutureForecastUsecase(
      ForecastRepository(
        NetworkForecastDatasource(Client()),
        LocalForecastDatasource(globalSharedPrefs),
      ),
    );
    //Initial function
    getFutureForecast();
  }

  late FutureForecastUsecase futureForecastUsecase;

  final City city;

  bool isLoading = false;

  List<DayForecast> dailyForecasts = [];

  getFutureForecast() async {
    _setLoadingState(true);

    final result = await futureForecastUsecase(city.location);
    if (result is Right<Failure, List<ForecastEntity>>) {
      dailyForecasts = _groupForecastsByDay(result.value);
    }

    _setLoadingState(false);
  }

  _groupForecastsByDay(List<ForecastEntity> forecasts) {
    List<DateTime> days = [];

    DateTime? matchDay;
    for (var value in forecasts) {
      var dateTime = Convertions.unixToDateTime(value.dt);
      if (dateTime.day != matchDay?.day) {
        days.add(dateTime);
      }
      matchDay = dateTime;
    }

    return days.map((x) {
      return DayForecast(
        day: x,
        hourlyForecast: forecasts.where((y) {
          return x.day == Convertions.unixToDateTime(y.dt).day;
        }).toList(),
      );
    }).toList();
  }

  _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }
}
