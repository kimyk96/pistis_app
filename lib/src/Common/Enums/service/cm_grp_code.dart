// ignore_for_file: constant_identifier_names

// 공통 코드 그룹 목록
enum CmGrpCode {
  LANGUAGE(1001, "언어"),
  TRANSLATION(1002, "번역본"),
  TESTAMENT(1003, "구약, 신약"),
  BOOK(1004, "성경"),
  BANNER(1005, "배너"),
  ;

  const CmGrpCode(this.code, this.desc);

  final int code;
  final String desc;

  // 코드로 enum 찾기
  static CmGrpCode fromCode(int code) {
    return CmGrpCode.values.firstWhere((e) => e.code == code);
  }
}
