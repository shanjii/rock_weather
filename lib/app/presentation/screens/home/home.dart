import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_weather/app/presentation/controllers/home_controller.dart';
import 'package:rock_weather/app/presentation/screens/home/widgets/home_card.dart';
import 'package:rock_weather/app/presentation/widgets/default_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Current weather"),
        ),
        body: Consumer<HomeController>(
          builder: (context, controller, _) {
            return RefreshIndicator(
              onRefresh: () async => await controller.getAllCurrentWeather(),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.isLoading ? null : 0,
                  ),
                  DefaultTextField(
                    padding: const EdgeInsets.all(10),
                    hintText: "Search for a city name",
                    onChanged: (p0) => controller.filterCities(p0),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredCities.length,
                      itemBuilder: (context, index) {
                        return HomeCard(
                          city: controller.filteredCities[index],
                        );
                      },
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
