import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pistis_app/src/Common/Data/global_constants.dart';
import 'package:pistis_app/src/Common/Enums/api/api_type.dart';
import 'package:pistis_app/src/Common/Data/api_response.dart';
import 'package:pistis_app/src/Common/Enums/error/api_error.dart';
import 'package:pistis_app/src/Common/Enums/error/etc_error.dart';
import 'package:pistis_app/src/Common/Enums/service/http_method.dart';
import 'package:pistis_app/src/Common/Exception/custom_exception.dart';
import 'package:pistis_app/src/Common/Model/session.dart';

class ApiClient {
  ApiClient() : defaultHeaders = _initializeHeaders();
  final Map<String, String> defaultHeaders;

  static Map<String, String> _initializeHeaders() {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (Session.accessTkn != null && Session.accessTkn!.isNotEmpty) {
      headers['GP-AUTH-TOKEN'] = Session.accessTkn!;
    }

    if (Session.userId != null && Session.userId!.isNotEmpty) {
      headers['GP-AUTH-ID'] = Session.userId!;
    }

    return headers;
  }

  /// API 호출
  Future<ApiResponse> call<T>(
    ApiType apiType, {
    dynamic data,
    Map<String, String>? headers,
    bool isFile = false, // 응답이 JSON 이 아닌 파일 타입의 경우
  }) async {
    try {
      return await _executeRequest(apiType, data: data, headers: headers, isFile: isFile);
    } on CustomException {
      rethrow;
    } on TimeoutException {
      return ApiResponse.error(ApiError.TimeOutError);
    } on SocketException {
      return ApiResponse.error(ApiError.SocketException);
    } on Exception catch (_) {
      return ApiResponse.error(EtcError.UnknownError);
    }
  }

  // 요청 실행
  Future<ApiResponse> _executeRequest(
    ApiType apiType, {
    dynamic data,
    Map<String, String>? headers,
    required bool isFile,
  }) async {
    final uri = Uri.parse(apiType.baseUrl + apiType.endPoint);
    final finalUri = apiType.httpMethod == HttpMethod.GET ? uri.replace(queryParameters: data) : uri;
    final finalHeaders = {...defaultHeaders, if (headers != null) ...headers};
    Duration timeout = GlobalConstants.defaultTimeout;

    final response = await _makeRequest(
      timeout,
      apiType.httpMethod,
      finalUri,
      headers: finalHeaders,
      body: apiType.httpMethod != HttpMethod.GET ? jsonEncode(data) : null,
    );

    return _makeResponse(response, isFile);
  }

  // 요청 만들기
  Future<http.Response> _makeRequest(
    Duration timeout,
    HttpMethod method,
    Uri uri, {
    Map<String, String>? headers,
    String? body,
  }) {
    final request = switch (method) {
      HttpMethod.GET => http.get(uri, headers: headers),
      HttpMethod.POST => http.post(uri, headers: headers, body: body),
      HttpMethod.PUT => http.put(uri, headers: headers, body: body),
      HttpMethod.PATCH => http.patch(uri, headers: headers, body: body),
      HttpMethod.DELETE => http.delete(uri, headers: headers, body: body),
    };

    return request.timeout(timeout);
  }

  // 응답 만들기
  ApiResponse _makeResponse(http.Response response, bool isFile) {
    if (isFile) {
      return switch (response.statusCode) {
        >= 200 && < 300 => ApiResponse.fromFile(response.bodyBytes),
        401 => ApiResponse.error(ApiError.Unauthorized),
        404 => ApiResponse.error(ApiError.NotFound),
        502 => ApiResponse.error(ApiError.BadGateway),
        _ => throw CustomException(EtcError.UnknownError),
      };
    }

    return switch (response.statusCode) {
      >= 200 && < 300 => ApiResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))),
      401 => ApiResponse.error(ApiError.Unauthorized),
      404 => ApiResponse.error(ApiError.NotFound),
      502 => ApiResponse.error(ApiError.BadGateway),
      _ => throw CustomException(EtcError.UnknownError),
    };
  }
}
