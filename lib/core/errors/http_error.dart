import 'package:http/http.dart';

class HttpError implements Exception {
  final int? statusCode;
  final String? message;
  final Response? response;

  HttpError({
    this.statusCode,
    this.message,
    this.response,
  });

  bool between(int begin, int end) {
    return statusCode != null && statusCode! >= begin && statusCode! <= end;
  }
  
  bool get connectionError => statusCode == null;

  bool get isBadRequest => statusCode == 400;

  bool get isUnauthorized => statusCode == 401;

  bool get isForbidden => statusCode == 403;

  bool get isNotFound => statusCode == 404;

  bool get isServerError => between(500, 599);

  bool get isOk => between(200, 299);

  bool get hasError => !isOk;

  @override
  String toString() => "HttpError: $statusCode $message";
}