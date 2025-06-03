import 'package:pistis_app/src/Common/Enums/service/cm_code.dart';
import 'package:pistis_app/src/Common/Provider/bible_provider.dart';

class Bible {
  final int languageCode;
  final int translateCode;
  final int promiseCode;
  final int bookCode;
  final int chapterNo;
  final int verseNo;
  final String verseDesc;

  Bible({
    required this.languageCode,
    required this.translateCode,
    required this.promiseCode,
    required this.bookCode,
    required this.chapterNo,
    required this.verseNo,
    required this.verseDesc,
  });

  // 다음장 정보 생성
  Bible getNextChapter({required List<BookInfo> bookInfoList}) {
    // 다음장 있는지 검증
    int indexOfBook = bookInfoList.indexWhere((bookInfo) => bookInfo.bookCode == bookCode);
    BookInfo targetBookInfo = bookInfoList[indexOfBook];
    int targetBookMaxChapterNo = targetBookInfo.chapterCnt;
    int targetBookCode = bookCode;
    int targetChapterNo = chapterNo + 1;
    if (chapterNo + 1 > targetBookMaxChapterNo) {
      if (indexOfBook + 1 == 66) {
        targetBookCode = bookInfoList[0].bookCode;
      } else {
        targetBookCode = bookInfoList[indexOfBook + 1].bookCode;
      }
      targetChapterNo = 1;
    }
    int targetPromiseCode = CmCode.OLD_TESTAMENT.code;
    if (targetBookCode > 10040039) targetPromiseCode = CmCode.NEW_TESTAMENT.code;

    return Bible(
      languageCode: languageCode,
      translateCode: translateCode,
      promiseCode: targetPromiseCode,
      bookCode: targetBookCode,
      chapterNo: targetChapterNo,
      verseNo: 0,
      verseDesc: '',
    );
  }

  // 특정 절 선택시
  Bible setVerse({required List<BookInfo> bookInfoList, required int bookCode, required int chapterNo, required int verseNo}) {
    int targetPromiseCode = CmCode.OLD_TESTAMENT.code;
    if (bookCode > 10040039) targetPromiseCode = CmCode.NEW_TESTAMENT.code;

    return Bible(
      languageCode: languageCode,
      translateCode: translateCode,
      promiseCode: targetPromiseCode,
      bookCode: bookCode,
      chapterNo: chapterNo,
      verseNo: verseNo,
      verseDesc: '',
    );
  }

  // 빈 성경 생성
  Bible.empty()
      : languageCode = CmCode.KOREAN.code,
        translateCode = CmCode.KOR_TRANSLATION_REVISION.code,
        promiseCode = CmCode.OLD_TESTAMENT.code,
        bookCode = CmCode.GENESIS.code,
        chapterNo = 1,
        verseNo = 0,
        verseDesc = '';

  factory Bible.fromJson(Map<String, dynamic> json) {
    return Bible(
      languageCode: json['language_code'] ?? 0,
      translateCode: json['translate_code'] ?? 0,
      promiseCode: json['promise_code'] ?? 0,
      bookCode: json['book_code'] ?? 0,
      chapterNo: json['chapter_no'] ?? 0,
      verseNo: json['verse_no'] ?? 0,
      verseDesc: json['verse_desc'] ?? "",
    );
  }

  toJson() {
    return {
      'language_code': languageCode,
      'translate_code': translateCode,
      'promise_code': promiseCode,
      'book_code': bookCode,
      'chapter_no': chapterNo,
      'verse_no': verseNo,
      'verse_desc': verseDesc,
    };
  }
}
