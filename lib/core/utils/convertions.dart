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
    DateTime date = unixToDateTime(dt);
    return DateFormat(format).format(date);
  }

  ///Receives a Unix timestamp and returns it as a DateTime.
  static DateTime unixToDateTime(int dt) {
    //Multiply the dt by 1000 for a valid return since the timestamp is received in seconds
    return DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  }

  ///Receives a [String] and removes its diacritics and capitalization.
  static String simplifyString(String string) {
    var e = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var x = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < e.length; i++) {
      string = string.replaceAll(e[i], x[i]);
    }

    return string.toLowerCase();
  }
}
