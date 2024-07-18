import 'package:flutter/material.dart';
import 'package:rock_weather/app/presentation/common/constants.dart';

class DefaultTextField extends StatelessWidget {
  ///Default [TextField] widget that can be customized with optional parameters.

  const DefaultTextField({
    super.key,
    this.controller,
    this.horizontalMargin = 16,
    this.hintText,
    this.suffixIcon,
    this.suffixAction,
    this.padding = EdgeInsets.zero,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
    this.onChanged,
  });

  ///Can be used to provide an external [TextEditingController] to the [TextField].
  final TextEditingController? controller;

  ///How large the horizontal margin should be. If null the default value of 16 will be used. **Default: 16**
  final double horizontalMargin;

  ///Hint text to be displayed in the [TextField].
  final String? hintText;

  ///The padding around the [TextField]. **Default: zero**
  final EdgeInsets padding;

  ///Widget to be displayed at the right side of the [TextField].
  final Widget? suffixIcon;

  ///Receives a function to be activated when the [suffixIcon] widget is depressed.
  ///<br/>If [suffixIcon] is not provided, the [suffixAction] function will be ignored.
  final Function()? suffixAction;

  ///Used to enable or disable keyboard suggestions on the [TextField]. **Default: false**
  ///<br/>(Has the effect of a text underline while typing)
  final bool enableSuggestions;

  ///The default keyboard layout used for the [TextField]. **Default: [TextInputType.text]**
  final TextInputType textInputType;

  ///Amount of lines visible in the [TextField]. If set to null the [TextField] will automatically expand in height given the size of the text provided. **Default: 1**
  final int? maxLines;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        enableSuggestions: enableSuggestions,
        keyboardType: textInputType,
        onTapOutside: (event) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          focusedBorder: _textInputBorder(),
          border: _textInputBorder(),
          suffixIcon: _createIcon(suffixIcon, action: suffixAction),
        ),
      ),
    );
  }

  _createIcon(Widget? widget, {Function()? action}) {
    if (widget == null) return null;
    return SizedBox(
      width: 25,
      child: IconButton(
        onPressed: () => action != null ? action() : null,
        icon: widget,
      ),
    );
  }

  _textInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: Constants.defaultBorderRadiusAll,
    );
  }
}
