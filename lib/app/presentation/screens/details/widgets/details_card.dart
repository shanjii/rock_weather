import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/models/day_forecast.dart';
import 'package:rock_weather/app/presentation/widgets/generic_card.dart';
import 'package:rock_weather/core/utils/convertions.dart';

class DayForecastCard extends StatelessWidget {
  ///Display the forecast of a given [DayForecast] through the [forecast] parameter.
  const DayForecastCard({super.key, required this.forecast});

  final DayForecast forecast;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      height: 260,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: _createDateTitle(forecast.day),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var item in forecast.hourlyForecast)
                  _createWeatherEntry(context, item: item)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDateTitle(DateTime date) {
    return Column(
      children: [
        Text(
          DateFormat('dd').format(date),
          style: const TextStyle(fontSize: 32),
        ),
        Text(
          DateFormat('MMMM').format(date),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _createWeatherEntry(
    BuildContext context, {
    required ForecastEntity item,
  }) {
    final time = Convertions.formattedTimeFromTimestamp(
      dt: item.dt,
      format: "HH:mm",
    );

    return SizedBox(
      width: 150,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceBright,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time),
              Text(item.weather.first.main ?? ""),
              Column(
                children: [
                  _createLabelRow(
                    label: "Temperature:",
                    value: _formatValue(item.main.temp),
                  ),
                  _createLabelRow(
                    label: "Feels like:",
                    value: _formatValue(item.main.feelsLike),
                  ),
                  _createLabelRow(
                    label: "Wind speed:",
                    value: _formatValue(item.wind.speed),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createLabelRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  _formatValue(double? value) {
    return value?.toInt().toString() ?? "null";
  }
}
