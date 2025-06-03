class ErrorInfo {
  final String? code;

  ErrorInfo(this.code);

  factory ErrorInfo.fromJson(Map<String, dynamic> json) {
    return ErrorInfo(json['code']);
  }

  Map<String, dynamic> toJson() => {'code': code};

  @override
  String toString() {
    return 'ErrorInfo{code: $code}';
  }
}
