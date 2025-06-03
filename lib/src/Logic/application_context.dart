import 'package:pistis_app/src/Logic/bible/bible_controller.dart';
import 'package:pistis_app/src/Logic/bible/dao/bible_dao.dart';
import 'package:pistis_app/src/Logic/bible/service/bible_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationContext {
  static final ApplicationContext _instance = ApplicationContext._internal();
  factory ApplicationContext() => _instance;
  ApplicationContext._internal();
  static ApplicationContext get instance => _instance;

  // 성경 컨트롤러
  final BibleController bibleController = BibleController(BibleService(BibleDao(Supabase.instance.client)));
}

final applicationContext = ApplicationContext();
