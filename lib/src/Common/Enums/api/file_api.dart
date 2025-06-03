import 'package:pistis_app/src/Common/Config/app_config.dart';
import 'package:pistis_app/src/Common/Enums/api/api_type.dart';
import 'package:pistis_app/src/Common/Enums/service/http_method.dart';

// 도메인 명은 변수명에서 제외
enum FileApi implements ApiType {
  ////////////////////////////////
  /// API
  ////////////////////////////////
  // 조회 예시
  getDownloadStoreGoods(HttpMethod.GET, "/file/download/store/goods"),
  ;

  const FileApi(this.httpMethod, this.endPoint);

  @override
  final HttpMethod httpMethod;
  @override
  final String endPoint;

  @override
  String get baseUrl => AppConfig.baseUrl;
}
