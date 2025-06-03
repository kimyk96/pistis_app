import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pistis_app/src/Common/Provider/go_router_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  // 유저 정보
  User? _user = Supabase.instance.client.auth.currentUser;
  User? get user => _user;
  String get avatarUrl => user?.userMetadata?["avatar_url"] ?? "";
  String get userName => user?.userMetadata?["user_name"] ?? "";

  UserProvider();

  // 유저 정보 초기화
  Future<void> init({required User user}) async {
    _user = user;
    notifyListeners();
  }

  // 로그인
  Future<void> signIn() async {
    await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.kakao,
      redirectTo: "com.pistis.supabase://oauth",
      authScreenLaunchMode: LaunchMode.platformDefault,
    );
    notifyListeners();
  }

  // 로그아웃
  Future<void> logout({required WidgetRef ref}) async {
    GoRouter router = ref.read(goRouterProvider);
    await Supabase.instance.client.auth.signOut();
    router.go("/start");
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider();
});
