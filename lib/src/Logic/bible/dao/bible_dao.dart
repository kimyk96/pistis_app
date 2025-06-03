import 'package:pistis_app/src/Common/Table/Supabase/bible.dart';
import 'package:pistis_app/src/Common/Table/Supabase/bible_detail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BibleDao {
  final SupabaseClient _client;
  BibleDao(this._client);

  // 현재 읽고 있는 성경 정보 조회
  Future<Bible?> getCurrentBible({required String userUid}) async {
    try {
      dynamic result = await _client //
          .from('USER_BIBLE')
          .select()
          .eq('user_uid', userUid)
          .single();
      return Bible.fromJson(result as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  // 현재 읽고 있는 성경 정보 저장
  Future<bool> saveCurrentBible({required String userUid}) async {
    try {
      await _client //
          .from('USER_BIBLE')
          .insert({'user_uid': userUid});
      return true;
    } catch (e) {
      return false;
    }
  }

  // 현재 읽고 있는 성경 정보 업데이트
  Future<bool> updateCurrentBible({required String userUid, required Bible bible}) async {
    try {
      await _client //
          .from('USER_BIBLE')
          .update(
        {
          'language_code': bible.languageCode,
          'translate_code': bible.translateCode,
          'promise_code': bible.promiseCode,
          'book_code': bible.bookCode,
          'chapter_no': bible.chapterNo,
        },
      ) //
          .eq('user_uid', userUid);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 성경 조회
  Future<List<Bible>> getBible({required Bible bible}) async {
    List<Bible> bibleList = [];
    try {
      List<dynamic> data = await _client //
          .from('BIBLE')
          .select()
          .eq('language_code', bible.languageCode)
          .eq('translate_code', bible.translateCode)
          .eq('promise_code', bible.promiseCode)
          .eq('book_code', bible.bookCode)
          .eq('chapter_no', bible.chapterNo)
          .order('verse_no', ascending: true);
      if (data.isEmpty) return bibleList;
      bibleList = (data).map((json) => Bible.fromJson(json as Map<String, dynamic>)).toList();
    } catch (_) {}
    return bibleList;
  }

  // 성경 목차 정보 조회 - 구약
  Future<List<BibleDetail>> getOldTestamentBookDetailList() async {
    List<BibleDetail> bookDetailList = [];
    try {
      List<dynamic> data = await _client //
          .from('BIBLE_DETAIL')
          .select()
          .lt("book_code", 10040040)
          .order('book_code', ascending: true);
      if (data.isEmpty) return bookDetailList;
      bookDetailList = (data).map((json) => BibleDetail.fromJson(json as Map<String, dynamic>)).toList();
    } catch (_) {}
    return bookDetailList;
  }

  // 성경 목차 정보 조회 - 신약
  Future<List<BibleDetail>> getNewTestamentBookDetailList() async {
    List<BibleDetail> bookDetailList = [];
    try {
      List<dynamic> data = await _client //
          .from('BIBLE_DETAIL')
          .select()
          .gt("book_code", 10040039)
          .order('book_code', ascending: true);
      if (data.isEmpty) return bookDetailList;
      bookDetailList = (data).map((json) => BibleDetail.fromJson(json as Map<String, dynamic>)).toList();
    } catch (_) {}
    return bookDetailList;
  }
}
