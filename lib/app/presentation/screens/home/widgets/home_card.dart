import 'package:flutter/material.dart';
import 'package:rock_weather/app/domain/entities/forecast_entity.dart';
import 'package:rock_weather/app/presentation/models/city.dart';
import 'package:rock_weather/app/presentation/screens/details/details.dart';
import 'package:rock_weather/app/presentation/widgets/generic_card.dart';

class HomeCard extends StatelessWidget {
  ///Display data of the given [City] through the [city] parameter.
  ///
  ///If [City] does not contain a valid [ForecastEntity], an empty content message will be shown instead.
  const HomeCard({super.key, required this.city});

  ///Receives a [City], if the [ForecastEntity] is null the card will display an empty content message.
  final City city;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      child: _createContent(),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(city: city),
        ),
      ),
    );
  }

  _createContent() {
    if (city.forecast != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  city.location.name,
                  style: const TextStyle(fontSize: 28),
                ),
                Text(
                  city.forecast!.weather.first.main ?? "",
                  style: const TextStyle(fontSize: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _createLabelRow(
                      label: "Temperature:",
                      value: _formatValue(city.forecast!.main.temp),
                    ),
                    _createLabelRow(
                      label: "Feels like:",
                      value: _formatValue(city.forecast!.main.feelsLike),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.list, size: 32),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(city.location.name),
          const Text("No weather data cached"),
        ],
      );
    }
  }

  Widget _createLabelRow({
    required String label,
    required String value,
  }) {
    return Text(
      "$label $value",
      style: const TextStyle(fontSize: 16),
    );
  }

  _formatValue(double? value) {
    return value?.toInt().toString() ?? "null";
  }
}
