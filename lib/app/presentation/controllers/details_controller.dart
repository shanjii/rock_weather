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
import 'package:rock_weather/main.dart';

class DetailsController with ChangeNotifier {
  DetailsController({required this.city}) {
    futureForecastUsecase = FutureForecastUsecase(
      ForecastRepository(
        NetworkForecastDatasource(Client()),
        LocalForecastDatasource(globalSharedPrefs),
      ),
    );
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
      var dayGroups = _groupForecastsByDay(result.value);

      for (var day in dayGroups) {
        dailyForecasts.add(
          DayForecast(
            day: DateTime.fromMillisecondsSinceEpoch(day.first.dt * 1000),
            hourlyForecast: day,
          ),
        );
      }
    }

    _setLoadingState(false);
  }

  List<List<ForecastEntity>> _groupForecastsByDay(
    List<ForecastEntity> forecasts,
  ) {
    //Each day contains 8 weather reports, so we divide the length of our forecast list by that number to get our 5 day forecast chunks
    int chunks = (forecasts.length / 8).ceil();
    //Generate our 5 day forecast groupings
    return List.generate(
      chunks,
      (i) => forecasts.skip(i * 8).take(8).toList(),
    );
  }

  _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }
}
