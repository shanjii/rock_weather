import 'package:flutter/material.dart';
import 'package:rock_weather/app/presentation/common/constants.dart';

class GenericCard extends StatelessWidget {
  ///A card widget that can be customized with optional parameters.
  ///Should receive a [child] widget that will be placed inside the [GenericCard] and
  ///can also receive a [onTap] function optionally.
  const GenericCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(10),
    this.height = 200,
  });

  ///A widget to be placed inside the [GenericCard].
  final Widget child;

  ///An optional [VoidCallback]
  final VoidCallback? onTap;

  ///A padding that will be used inside of the widget. **Default: 10**
  final EdgeInsets padding;

  ///A margin for the outside of the widget. **Default: 10**
  final EdgeInsets margin;

  ///The height of the [GenericCard]. **Default: 200**
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        child: Card(
          shape: Constants.defaultRectangleBorder,
          child: InkWell(
            borderRadius: Constants.defaultBorderRadius,
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
