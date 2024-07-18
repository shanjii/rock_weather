import 'package:intl/intl.dart';

class Convertions {
  static String formattedTimeFromTimestamp({
    String format = 'dd/MM/yyyy, HH:mm',
    required int dt,
  }) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat(format).format(date);
  }

  // static DateTime dayFromTimestamp
}
