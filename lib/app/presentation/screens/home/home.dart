import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_weather/app/presentation/common/constants.dart';
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
            return NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  _createLoadingIndicatorSliver(controller),
                  _createSearchBarSliver(controller),
                ];
              },
              body: RefreshIndicator(
                onRefresh: () async => await controller.getAllCurrentWeather(),
                child: ListView.builder(
                  itemCount: controller.filteredCities.length,
                  itemBuilder: (context, index) {
                    return HomeCard(
                      city: controller.filteredCities[index],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _createSearchBarSliver(HomeController controller) {
    return SliverAppBar(
      toolbarHeight: 80,
      floating: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Constants.defaultBorderRadius,
          bottomRight: Constants.defaultBorderRadius,
        ),
      ),
      title: DefaultTextField(
        hintText: "Search for a city name",
        onChanged: (p0) => controller.filterCities(p0),
        suffixIcon: const Icon(Icons.search),
        suffixAction: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
      ),
    );
  }

  _createLoadingIndicatorSliver(HomeController controller) {
    return SliverAppBar(
      toolbarHeight: 5,
      titleSpacing: 0,
      pinned: true,
      title: LinearProgressIndicator(
        value: controller.isLoading ? null : 0,
        minHeight: 5,
      ),
    );
  }
}
