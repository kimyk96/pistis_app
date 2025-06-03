import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pistis_app/src/Common/Data/result.dart';
import 'package:pistis_app/src/Common/Enums/error/error_type.dart';
import 'package:pistis_app/src/Common/Table/Supabase/bible.dart';
import 'package:pistis_app/src/Logic/application_context.dart';

class BibleProvider extends ChangeNotifier {
  final ApplicationContext _ac = ApplicationContext();

  // 현재 성경 정보
  Bible _currentBible = Bible.empty();
  Bible get currentBible => _currentBible;

  // 현재 성경 본문
  List<Bible> _bibleList = [];
  List<Bible> get bibleList => _bibleList;

  // 성경 정보 전체 키
  List<GlobalKey> _bibleGlobalKeyList = [];
  List<GlobalKey> get bibleGlobalKeyList => _bibleGlobalKeyList;

  // 성경 목차 정보
  List<BookInfo> _bookInfoList = [];
  List<BookInfo> get bookInfoList => _bookInfoList;

  BibleProvider();

  // 현재 읽고 있는 성경 설정
  Future<void> init() async {
    // 현재 성경 정보
    Result<Bible, ErrorType> currentResult = await _ac.bibleController.getCurrentBible();
    if (!currentResult.isError) _currentBible = currentResult.data!;

    // 성경 목차 정보
    Result<List<BookInfo>, ErrorType> bookInfoResult = await _ac.bibleController.getBookInfoList();
    if (!bookInfoResult.isError) _bookInfoList = bookInfoResult.data!;

    // 현재 성경 본문
    await _setBibleList();
    notifyListeners();
  }

  // 다음장 선택시 성경 정보 설정
  Future<void> setNextChapter() async {
    // 현재 성경 정보
    _currentBible = _currentBible.getNextChapter(bookInfoList: _bookInfoList);

    // 현재 성경 본문
    await _setBibleList();
    notifyListeners();
  }

  // 특정 절 선택시
  Future<void> setVerse({
    required int? bookCode,
    required int? chapterNo,
    required int verseNo,
  }) async {
    // 현재 성경 정보
    _currentBible = _currentBible.setVerse(
      bookInfoList: _bookInfoList,
      bookCode: bookCode ?? _currentBible.bookCode,
      chapterNo: chapterNo ?? _currentBible.chapterNo,
      verseNo: verseNo,
    );

    // 현재 성경 본문
    await _setBibleList();
    notifyListeners();
  }

  // 성경 본문 세팅
  Future<void> _setBibleList() async {
    // 성경 본문 조회
    Result<List<Bible>, ErrorType> bookResult = await _ac.bibleController.getBible(bible: _currentBible);
    if (!bookResult.isError) {
      _bibleList = bookResult.data!;
      // 성경 전체 키 세팅
      _bibleGlobalKeyList = List.generate(_bibleList.length, (index) => GlobalKey(debugLabel: "bible_${_bibleList[index].verseNo}"));
    }
    notifyListeners();
  }
}

final bibleProvider = ChangeNotifierProvider<BibleProvider>((ref) {
  return BibleProvider();
});

// 성경 상세 정보
class BookInfo {
  final int bookCode;
  final String bookNm;
  final List<ChapterInfo> chapterList;
  int get chapterCnt => chapterList.length;

  BookInfo({required this.bookCode, required this.bookNm, required this.chapterList});
}

// 장 상세 정보
class ChapterInfo {
  final int chapterNo;
  final int verseCnt;

  ChapterInfo({required this.chapterNo, required this.verseCnt});
}
