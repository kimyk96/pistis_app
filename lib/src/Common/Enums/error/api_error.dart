// ignore_for_file: constant_identifier_names

import 'package:pistis_app/src/Common/Enums/error/error_type.dart';

enum ApiError implements ErrorType {
  // API
  NotSupportedHttpMethod("0001", "지원하지 않는 HTTP METHOD 입니다."),
  NoErrorInfo("0002", "에러 정보가 없습니다."),
  NotEnoughQuery("0003", "Query의 필수요소가 부족합니다."),
  NotEnoughBody("0004", "Body의 필수요소가 부족합니다."),
  TimeOutError("0005", "TimeOut 발생했습니다."),
  SocketException("0006", "네트워크 연결에 실패했습니다."),
  InvalidData("0007", "유효하지 않은 데이터입니다."),

  // Status
  Unauthorized("0401", "인증되지 않은 요청입니다."),
  NotFound("0404", "서버 API를 찾을 수 없습니다."),
  BadGateway("0502", "서버 게이트웨이 에러입니다."),
  ;

  const ApiError(String status, String message)
      : status = _status + status,
        message = _message + message;

  static const String _status = "901";
  static const String _message = "API 에러: ";

  @override
  final String status;
  @override
  final String message;

  @override
  String get error => name;

  @override
  String toString() {
    return '[$error] $message';
  }
}
