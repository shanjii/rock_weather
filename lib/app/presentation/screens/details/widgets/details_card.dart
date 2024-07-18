import 'package:flutter/material.dart';
import 'package:rock_weather/app/presentation/models/day_forecast.dart';
import 'package:rock_weather/app/presentation/widgets/generic_card.dart';
import 'package:rock_weather/core/utils/convertions.dart';

class DayForecastCard extends StatelessWidget {
  ///Display the forecast of a given [DayForecast] through the [forecast] parameter.
  const DayForecastCard({super.key, required this.forecast});

  final DayForecast forecast;

  @override
  Widget build(BuildContext context) {
    return GenericCard(child: _createContent());
  }

  _createContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(child: Text(forecast.day.day.toString())),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in forecast.hourlyForecast)
              _createWeatherEntry(
                "Temperature at ${Convertions.formattedTimeFromTimestamp(dt: item.dt, format: "HH")}:",
                item.main.temp,
              ),
          ],
        ),
      ],
    );
  }
}

Widget _createWeatherEntry(String name, dynamic value) {
  return Text("$name ${value ?? "Unavailable"}");
}
