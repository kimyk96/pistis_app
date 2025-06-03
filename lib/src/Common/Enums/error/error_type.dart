import 'package:flutter/cupertino.dart';

@protected
class ErrorType {
  final String status;
  final String message;
  final String error;

  ErrorType(this.status, this.message, this.error);

  @override
  String toString() {
    return '[$error] $message';
  }
}
