class BibleDetail {
  final int bookCode;
  final int chapterNo;
  final int verseCnt;

  BibleDetail({required this.bookCode, required this.chapterNo, required this.verseCnt});

  // from json
  factory BibleDetail.fromJson(Map<String, dynamic> json) {
    return BibleDetail(
      bookCode: json['book_code'],
      chapterNo: json['chapter_no'],
      verseCnt: json['verse_cnt'],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'book_code': bookCode,
      'chapter_no': chapterNo,
      'verse_cnt': verseCnt,
    };
  }
}
