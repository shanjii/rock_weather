import 'package:fpdart/fpdart.dart';
import 'package:rock_weather/core/errors/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
