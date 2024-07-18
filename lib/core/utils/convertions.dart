import 'package:intl/intl.dart';

class Convertions {
  ///Receives a Unix timestamp and converts it into a formatted [String],
  ///an optional [format] value can be included for custom formatting.
  ///
  ///Default format: ```dd/MM/yyyy, HH:mm```
  static String formattedTimeFromTimestamp({
    String format = 'dd/MM/yyyy, HH:mm',
    required int dt,
  }) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat(format).format(date);
  }

  // static DateTime dayFromTimestamp
}
