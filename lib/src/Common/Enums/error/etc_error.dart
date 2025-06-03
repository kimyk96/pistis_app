// ignore_for_file: constant_identifier_names

import 'package:pistis_app/src/Common/Enums/error/error_type.dart';

enum EtcError implements ErrorType {
  ProcessStartError("0001", "프로세스 실행에 실패했습니다."),
  ProcessKillError("0002", "프로세스 종료에 실패했습니다."),
  ProcessIsAlreadyRunning("0003", "프로세스가 이미 실행중입니다."),
  ProcessIsNotRunning("0004", "프로세스가 실행중이 아닙니다."),
  ProcessFileIsNotFound("0005", "프로세스 파일이 존재하지 않습니다."),
  ProcessUtilsCanOnlyWindows("0006", "프로세스 유틸은 윈도우에서만 실행이 가능합니다."),
  IsPortInUse("0007", "이미 사용 중인 포트입니다."),
  ErrorParseStringToInt("0008", "숫자로 변환중 에러가 발생했습니다."),
  FailToProcessQueue("0009", "큐 처리에 실패했습니다."),

  UnknownError("9999", "알 수 없는 에러입니다."),
  ;

  const EtcError(String status, String message)
      : status = _status + status,
        message = _message + message;

  static const String _status = "999";
  static const String _message = "기타 에러: ";

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
