import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_weather/app/presentation/screens/details/provider/details_provider.dart';
import 'package:rock_weather/core/values/locations.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.location});

  final LocationInfo location;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("${location.name} forecast"),
        ),
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
