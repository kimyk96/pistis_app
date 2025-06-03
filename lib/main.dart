import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pistis_app/src/Pages/home/home_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 로컬 알림 플러그인
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  // Flutter binding 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 슈퍼베이스 초기화
  await Supabase.initialize(
    url: 'https://xicbgdtwjqwhaimcrwao.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhpY2JnZHR3anF3aGFpbWNyd2FvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExNjUwMzUsImV4cCI6MjA1Njc0MTAzNX0.AEAQ6C2I-AtX8ozo70JgMgrV2DQd2IQwr7Eb6Zx6Ct0',
  );

  // 시스템 UI 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
  );

  // 파이어베이스 초기화
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // 알림 표시
  });

  // 로컬 알림 플러그인 초기화
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 전역 에러 처리
  FlutterError.onError = (detail) async {
    try {
      String stack = detail.stack == null ? detail.toString() : detail.stack.toString();
      print(stack);
    } catch (_) {}
  };

  // 앱 시작
  runApp(const ProviderScope(child: HomeView()));
}
