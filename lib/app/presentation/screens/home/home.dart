import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_weather/app/presentation/screens/home/provider/home_provider.dart';
import 'package:rock_weather/app/presentation/screens/home/widgets/home_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Rock Weather"),
        ),
        body: Consumer(
          builder: (context, HomeProvider provider, _) {
            return Column(
              children: [
                LinearProgressIndicator(value: provider.isLoading ? null : 0),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: provider.forecasts.length,
                    itemBuilder: (context, index) {
                      return HomeCard(
                        forecast: provider.forecasts[index],
                        location: provider.locations[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
