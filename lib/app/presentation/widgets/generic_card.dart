import 'package:flutter/material.dart';
import 'package:rock_weather/app/presentation/common/constants.dart';

class GenericCard extends StatelessWidget {
  ///A default [Card] widget.
  ///
  ///A card widget that can be customized with optional parameters.
  ///Should receive a [child] widget that will be placed inside the [GenericCard].
  const GenericCard({
    super.key,
    required this.child,
    this.onTap,
  });

  ///A widget to be placed inside the [GenericCard].
  final Widget child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 200,
        child: Card(
          shape: defaultRectangleBorder,
          child: InkWell(
            borderRadius: defaultBorderRadius,
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
