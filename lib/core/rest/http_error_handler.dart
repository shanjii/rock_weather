import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class HttpErrorHandler {
  static Map<String, dynamic> handleResponse(Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw HttpException('${response.statusCode}');
  }

  static List<dynamic> handleListResponse(Response response) {
    if (response.statusCode == 200) {
      return jsonDecode((response.body))['list'];
    }

    throw HttpException('${response.statusCode}');
  }
}
