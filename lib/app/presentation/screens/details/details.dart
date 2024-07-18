import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_weather/app/presentation/controllers/details_controller.dart';
import 'package:rock_weather/app/presentation/models/city.dart';
import 'package:rock_weather/app/presentation/screens/details/widgets/details_card.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailsController(city: city),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          title: Text("${city.location.name} forecast"),
        ),
        body: Consumer<DetailsController>(
          builder: (context, controller, _) {
            return RefreshIndicator(
              onRefresh: () async => await controller.getFutureForecast(),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.isLoading ? null : 0,
                  ),
                  if (controller.dailyForecasts.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: controller.dailyForecasts.length,
                        itemBuilder: (context, index) {
                          return DayForecastCard(
                            forecast: controller.dailyForecasts[index],
                          );
                        },
                      ),
                    )
                  else if (!controller.isLoading)
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No weather forecast cached"),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
