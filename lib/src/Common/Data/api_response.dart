import 'dart:typed_data';
import 'package:pistis_app/src/Common/Vo/error_info.dart';
import 'package:pistis_app/src/Common/Vo/paging_info.dart';
import 'package:pistis_app/src/Common/Enums/error/api_error.dart';
import 'package:pistis_app/src/Common/Enums/error/error_type.dart';
import 'package:pistis_app/src/Common/Exception/custom_exception.dart';

class ApiResponse {
  final ErrorInfo? error;
  final PagingInfo? pageInfo;
  final dynamic results;
  final String status;

  // Default constructor for a successful response with optional pagination
  ApiResponse({
    this.error,
    this.pageInfo,
    this.results,
    this.status = "200",
  });

  // Success response with just results
  ApiResponse.success(this.results)
      : status = "200",
        error = null,
        pageInfo = null;

  ApiResponse.voidSuccess()
      : status = "200",
        results = "success",
        error = null,
        pageInfo = null;

  // Success response with pagination
  ApiResponse.successWithPaging(this.pageInfo, this.results)
      : status = "200",
        error = null;

  // Error response
  ApiResponse.error(ErrorType errorType)
      : error = ErrorInfo(errorType.error),
        status = errorType.status,
        results = errorType.message,
        pageInfo = null;

  // Exception response
  ApiResponse.exception(Exception exception)
      : error = ErrorInfo(exception.toString()),
        status = "9999999",
        results = exception.toString(),
        pageInfo = null;

  // Check if response contains an error
  bool hasError() => error != null;

  // Factory constructor to create an instance from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] as String,
      results: json['results'],
      error: json['error'] != null ? ErrorInfo.fromJson(json['error']) : null,
      pageInfo: json['pageInfo'] != null ? PagingInfo.fromJson(json['pageInfo']) : null,
    );
  }

  // 파일 리턴
  factory ApiResponse.fromFile(Uint8List uint8List) {
    return ApiResponse(
      status: "200",
      results: uint8List,
      error: null,
      pageInfo: null,
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'results': results,
      if (error != null) 'error': error!.toJson(),
      if (pageInfo != null) 'pageInfo': pageInfo!.toJson(),
    };
  }

  @override
  String toString() => "[$status] ${results.toString()}";

  ErrorType get errorType {
    return hasError() ? ErrorType(status, results.toString(), error!.code!) : throw CustomException(ApiError.NoErrorInfo);
  }
}
