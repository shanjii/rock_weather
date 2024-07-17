import 'package:flutter/material.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/screens/details/details.dart';
import 'package:rock_weather/app/presentation/widgets/generic_card.dart';
import 'package:rock_weather/core/values/locations.dart';

///
class HomeCard extends StatelessWidget {
  ///Default HomeCard.
  ///
  ///Display data from [ForecastEntity] through the [forecast] parameter.
  ///
  ///If a [ForecastEntity] is not received, an empty content message will be shown instead.
  const HomeCard({super.key, required this.forecast, required this.location});

  ///A nullable [forecast] of [ForecastEntity] type.
  final ForecastEntity? forecast;

  final LocationInfo location;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      child: _createContent(),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Details(location: location)),
      ),
    );
  }

  _createContent() {
    if (forecast != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(forecast!.weather.first.main ?? ""),
        ],
      );
    } else {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Empty"),
        ],
      );
    }
  }
}
