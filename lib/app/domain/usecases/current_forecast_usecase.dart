import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/repositories/i_forecast_repository.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/usecase/usecase.dart';
import 'package:rock_weather/core/values/locations.dart';

class CurrentForecastUsecase implements Usecase<ForecastEntity, LocationInfo> {
  IForecastRepository forecastRepository;
  CurrentForecastUsecase(this.forecastRepository);

  @override
  Future<Either<Failure, ForecastEntity>> call(LocationInfo info) async {
    return forecastRepository.getCurrentForecast(info);
  }
}
