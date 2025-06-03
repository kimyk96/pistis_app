import 'package:pistis_app/src/Common/Enums/error/error_type.dart';

class CustomException implements Exception {
  final ErrorType _errorType;

  CustomException(this._errorType);

  ErrorType get errorType => _errorType;
}
