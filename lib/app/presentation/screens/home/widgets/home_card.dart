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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(city.location.name),
          Column(
            children: [
              _createWeatherEntry(
                "Clouds:",
                city.forecast!.weather.first.main,
              ),
              _createWeatherEntry(
                "Temperature:",
                city.forecast!.main.temp,
              ),
              _createWeatherEntry(
                "Feels like:",
                city.forecast!.main.feelsLike,
              ),
            ],
          ),
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

  Widget _createWeatherEntry(String name, dynamic value) {
    return Text("$name ${value ?? "Unavailable"}");
  }
}
