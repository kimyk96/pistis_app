// API 통신을 위한 로그인 세션 정보
class Session {
  static String? accessTkn;
  static String? userId;

  Session._();

  // 대리점 사원 로그인시 사용
  static void fromAgencyLogin(String accessTkn, String userId) {
    Session.accessTkn = accessTkn;
    Session.userId = userId;
  }

  // 토큰 요청시 사용
  static void fromRequestToken(String accessTkn, String userId) {
    Session.accessTkn = accessTkn;
    Session.userId = userId;
  }

  static void clear() {
    accessTkn = null;
    userId = null;
  }
}
