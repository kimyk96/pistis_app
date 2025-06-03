import 'package:pistis_app/src/Common/Data/result.dart';
import 'package:pistis_app/src/Common/Enums/error/error_type.dart';
import 'package:pistis_app/src/Common/Provider/bible_provider.dart';
import 'package:pistis_app/src/Common/Table/Supabase/bible.dart';
import 'package:pistis_app/src/Logic/bible/service/bible_service.dart';

class BibleController {
  final BibleService _bibleService;
  BibleController(this._bibleService);

  // 현재 읽고 있는 성경 정보 조회
  Future<Result<Bible, ErrorType>> getCurrentBible() async {
    return await _bibleService.getCurrentBible();
  }

  // 성경 본문 불러오기
  Future<Result<List<Bible>, ErrorType>> getBible({required Bible bible}) async {
    return await _bibleService.getBible(bible: bible);
  }

  // 성경 목차 정보 불러오기
  Future<Result<List<BookInfo>, ErrorType>> getBookInfoList() async {
    return await _bibleService.getBookInfoList();
  }
}
