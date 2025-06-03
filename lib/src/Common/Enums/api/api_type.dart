import 'package:flutter/foundation.dart';
import 'package:pistis_app/src/Common/Enums/service/http_method.dart';

@protected
class ApiType {
  final HttpMethod httpMethod;
  final String endPoint;
  final String baseUrl;

  ApiType(this.httpMethod, this.endPoint, this.baseUrl);
}
