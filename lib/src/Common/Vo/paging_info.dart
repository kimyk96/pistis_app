class PagingInfo {
  final int currentPage;
  final int totalPages;

  PagingInfo({required this.currentPage, required this.totalPages});

  factory PagingInfo.fromJson(Map<String, dynamic> json) {
    return PagingInfo(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'totalPages': totalPages,
      };
}
