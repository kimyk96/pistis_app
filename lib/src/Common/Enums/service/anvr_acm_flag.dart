// ignore_for_file: constant_identifier_names

enum AnvrAcmFlag {
  None("N"), // 미사용
  Birth("B"), // 생일
  Wedding("W"), // 결혼기념일
  ;

  const AnvrAcmFlag(this.flag);

  final String flag;

  String get value => flag;
}
