import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pistis_app/src/Common/Routes/Common/route_info.dart';
import 'package:pistis_app/src/Common/Routes/global_routes.dart';

// 전체 라우트
class Routers {
  // 기본 라우트 형식
  final List<RouteInfo> _list = [
    ...globalRoutes,
  ];

  // go route 형식 with no transition
  GoRouter getRoutes() {
    List<GoRoute> routes = _list.map((e) {
      return GoRoute(
        path: e.path,
        name: e.title,
        pageBuilder: (context, state) => NoTransitionPage(child: e.page),
      );
    }).toList();

    return GoRouter(
      initialLocation: "/start",
      routes: routes,
      observers: [
        _BackButtonObserver(),
      ],
    );
  }
}

class _BackButtonObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final context = route.navigator?.context;
    if (context != null) {
      final router = GoRouter.of(context);
      final location = router.routerDelegate.currentConfiguration.fullPath;
      if (location != '/') router.go('/');
      if (location == '/') exit(0);
    }
  }
}
