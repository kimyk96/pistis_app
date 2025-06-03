// ignore_for_file: constant_identifier_names

// 공통 코드 목록
enum CmCode {
  // 1001언어코드
  KOREAN(10010001, "한국어"),
  ENGLISH(10010002, "영어"),

  // 1002번역본코드
  KOR_TRANSLATION_REVISION(10020001, "개역개정"),
  KOR_TRANSLATION(10020002, "개역한글"),

  // 1003구약, 신약코드
  OLD_TESTAMENT(10030001, "구약"),
  NEW_TESTAMENT(10030002, "신약"),

  // 1004성경코드
  GENESIS(10040001, "창세기"),
  EXODUS(10040002, "출애굽기"),
  LEVITICUS(10040003, "레위기"),
  NUMBERS(10040004, "민수기"),
  DEUTERONOMY(10040005, "신명기"),
  JOSHUA(10040006, "여호수아"),
  JUDGES(10040007, "사사기"),
  RUTH(10040008, "룻기"),
  SAMUEL_1(10040009, "사무엘상"),
  SAMUEL_2(10040010, "사무엘하"),
  KINGDOM_1(10040011, "열왕기상"),
  KINGDOM_2(10040012, "열왕기하"),
  CHRONICLES_1(10040013, "역대상"),
  CHRONICLES_2(10040014, "역대하"),
  EZRA(10040015, "에스라"),
  NEHEMIAH(10040016, "느혜미야"),
  ESTHER(10040017, "에스더"),
  JOB(10040018, "욥기"),
  PSALMS(10040019, "시편"),
  PROVERBS(10040020, "잠언"),
  ECCLESIASTES(10040021, "전도서"),
  SONG_OF_SONGS(10040022, "아가"),
  ISAIAH(10040023, "이사야"),
  JEREMIAH(10040024, "예레미야"),
  JEREMIAH_AFFLICTION(10040025, "예레미야애가"),
  EZEL(10040026, "에스겔"),
  DANIEL(10040027, "다니엘"),
  HOSEA(10040028, "호세아"),
  JOEL(10040029, "요엘"),
  AMOS(10040030, "아모스"),
  OBADIAH(10040031, "오바댜"),
  JONAH(10040032, "요나"),
  MICAH(10040033, "미가"),
  NAHUM(10040034, "나훔"),
  HABAKKUK(10040035, "하박국"),
  ZEPHANIAH(10040036, "스바냐"),
  HAGGAI(10040037, "학개"),
  ZECHARIAH(10040038, "스가랴"),
  MALACHI(10040039, "말라기"),
  MATTHEW(10040040, "마태복음"),
  MARK(10040041, "마가복음"),
  LUKE(10040042, "누가복음"),
  JOHN(10040043, "요한복음"),
  ACTS(10040044, "사도행전"),
  ROMANS(10040045, "로마서"),
  CORINTHIANS_1(10040046, "고린도전서"),
  CORINTHIANS_2(10040047, "고린도후서"),
  GALATIANS(10040048, "갈라디아서"),
  EPHESIANS(10040049, "에베소서"),
  PHILIPPIANS(10040050, "빌립보서"),
  GOLOSERIANS(10040051, "골로세서"),
  THESSALONIANS_1(10040052, "데살로니가전서"),
  THESSALONIANS_2(10040053, "데살로니가후서"),
  TIMOTHY_1(10040054, "디모데전서"),
  TIMOTHY_2(10040055, "디모데후서"),
  TITUS(10040056, "디도서"),
  PHILEMON(10040057, "빌레몬서"),
  HEBREWS(10040058, "히브리서"),
  JAMES(10040059, "야고보서"),
  PETER_1(10040060, "베드로전서"),
  PETER_2(10040061, "베드로후서"),
  JOHN_1(10040062, "요한1서"),
  JOHN_2(10040063, "요한2서"),
  JOHN_3(10040064, "요한3서"),
  JUDE(10040065, "유다서"),
  REVELATION(10040066, "요한계시록"),

  // 1005배너코드
  MAIN_BANNER(10050001, "메인 배너"),
  BOOK_BANNER(10050002, "도서 배너"),
  MUSIC_BANNER(10050003, "음악 배너"),
  MORE_BANNER(10050004, "더보기 배너"),
  ;

  const CmCode(this.code, this.desc);

  final int code;
  final String desc;

  // 코드로 enum 찾기
  static CmCode fromCode(int code) {
    return CmCode.values.firstWhere((e) => e.code == code);
  }
}
