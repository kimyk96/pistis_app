import 'package:pistis_app/src/Common/Data/result.dart';
import 'package:pistis_app/src/Common/Enums/error/error_type.dart';
import 'package:pistis_app/src/Common/Enums/service/cm_code.dart';
import 'package:pistis_app/src/Common/Provider/bible_provider.dart';
import 'package:pistis_app/src/Common/Table/Supabase/bible.dart';
import 'package:pistis_app/src/Common/Table/Supabase/bible_detail.dart';
import 'package:pistis_app/src/Logic/bible/dao/bible_dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BibleService {
  final BibleDao _bibleDao;
  BibleService(this._bibleDao);

  // 현재 읽고 있는 성경 정보 조회
  Future<Result<Bible, ErrorType>> getCurrentBible() async {
    User? user = Supabase.instance.client.auth.currentUser;

    // 기본 성경 정보
    Bible defaultBible = Bible.empty();

    // 로그인 세션 확인
    // 현재 읽고 있는 성경 정보 조회
    if (user != null) {
      Bible? result = await _bibleDao.getCurrentBible(userUid: user.id);
      // 있으면 반환
      if (result != null) defaultBible = result;
      // 없으면 신규 생성
      if (result == null) await _bibleDao.saveCurrentBible(userUid: user.id);
    }
    return Success(defaultBible);
  }

  // 성경 본문 불러오기
  Future<Result<List<Bible>, ErrorType>> getBible({required Bible bible}) async {
    User? user = Supabase.instance.client.auth.currentUser;

    // 성경 본문 목록
    List<Bible> bibleList = [];

    // 성경 정보 조회
    List<Bible> result = await _bibleDao.getBible(bible: bible);
    if (result.isEmpty) bibleList = [];
    if (result.isNotEmpty) bibleList = result;

    // 유저 현재 성경 정보 갱신
    if (user != null) {
      await _bibleDao.updateCurrentBible(userUid: user.id, bible: bible);
    }

    return Success(bibleList);
  }

  // 성경 목차 정보 불러오기
  Future<Result<List<BookInfo>, ErrorType>> getBookInfoList() async {
    // 성경 목차 정보 목록
    List<BookInfo> bookInfoList = [];

    // 성경 목차 정보 조회
    List<BibleDetail> oldTestamentResult = await _bibleDao.getOldTestamentBookDetailList();
    List<BibleDetail> newTestamentResult = await _bibleDao.getNewTestamentBookDetailList();
    if (oldTestamentResult.isEmpty || newTestamentResult.isEmpty) bookInfoList = [];
    if (oldTestamentResult.isNotEmpty && newTestamentResult.isNotEmpty) {
      List<BibleDetail> bibleDetailList = [...oldTestamentResult, ...newTestamentResult];
      bookInfoList = bibleDetailList
          .fold<Map<int, List<BibleDetail>>>({}, (map, detail) {
            map.putIfAbsent(detail.bookCode, () => []).add(detail);
            return map;
          })
          .entries
          .map((entry) {
            return BookInfo(
                bookCode: entry.key,
                bookNm: CmCode.fromCode(entry.key).desc,
                chapterList: entry.value.map((detail) => ChapterInfo(chapterNo: detail.chapterNo, verseCnt: detail.verseCnt)).toList());
          })
          .toList();
    }
    return Success(bookInfoList);
  }
}
