import 'dart:convert';
import 'package:rock_weather/core/errors/failures.dart';

class CacheErrorHandler {
  static Map<String, dynamic> handleResponse(String? body) {
    if (body != null) {
      return jsonDecode(body);
    }

    throw const UnexpectedFailure();
  }

  static List<dynamic> handleListResponse(String? body) {
    if (body != null) {
      return jsonDecode((body));
    }

    throw const UnexpectedFailure();
  }
}
