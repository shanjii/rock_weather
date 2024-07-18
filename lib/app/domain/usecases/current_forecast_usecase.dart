import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/domain/repositories/i_forecast_repository.dart';
import 'package:rock_weather/app/presentation/models/location.dart';
import 'package:rock_weather/core/errors/failures.dart';
import 'package:rock_weather/core/usecase/usecase.dart';

class CurrentForecastUsecase implements Usecase<ForecastEntity, Location> {
  IForecastRepository forecastRepository;
  CurrentForecastUsecase(this.forecastRepository);

  @override
  Future<Either<Failure, ForecastEntity>> call(Location info) async {
    return forecastRepository.getCurrentForecast(info);
  }
}
